/************************************************************************
  Get priority conditions for each patient
*************************************************************************/
CREATE PROCEDURE create_rpt_appt_alerts(IN _endDate DATE) BEGIN

  DROP TEMPORARY TABLE IF EXISTS rpt_appt_alerts;
  CREATE TEMPORARY TABLE rpt_appt_alerts (
    patient_id  INT NOT NULL,
    alert   VARCHAR(100),
    action   VARCHAR(100)
  );
  CREATE INDEX rpt_appt_alerts_patient_id_idx ON rpt_appt_alerts(patient_id);

  -- Routine Viral Load
  -- Logic: 
  --        * No viral load and > 182 days since ART initiation date OR
  --        * Every two years after ART initiation
  --        * Max 20 patients per report, prioritize 15 - 45 (young to old)
  -- Alert: Due for routine VL
  -- Do this today: Needs routine VL
  -- Note:
  --      * This uses start_date from the ART register (in pentaho) to determine ART Initiation
  INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
    SELECT r.patient_id, 'Due for routine VL', 'Needs routine VL'
    FROM    rpt_active_art r
    INNER JOIN (SELECT * FROM 
                    (SELECT * 
                     FROM mw_art_register 
                     ORDER BY start_date asc) ari
                     GROUP BY patient_id) ar
                 ON ar.patient_id = r.patient_id
    LEFT JOIN  (SELECT * 
                FROM (SELECT * 
                      FROM mw_lab_tests
                      WHERE test_type = "Viral Load"
                      ORDER BY date_collected desc) ti 
                GROUP BY patient_id) t
                ON r.patient_id = t.patient_id
    WHERE
      ( 
        ( 
            lab_test_id IS NULL -- no test
          AND
            DATEDIFF(_endDate,start_date) > 182 -- 6 months after *enrollment* (should be ART start)
        )
        OR
        ( -- within 2y/4y/6y/... years to 2y+90d/4y+90d/6y+90d/... of *enrollment* (should be ART start)
          DATEDIFF(_endDate,start_date) % 730 < 90 -- within 90 days after 2y anniversary
          AND DATEDIFF(@endDate,start_date) > 182 -- 6 months after *enrollment* (should be ART start)
          AND (
                DATEDIFF(_endDate,date_collected) > DATEDIFF(_endDate,start_date) % 730 + 90 -- no test 90d before 2y anniversary to present
              OR 
                lab_test_id IS NULL -- no test
              )
          
        )
      )
  ;




  -- High Viral Load
  -- Logic:
  --        * Last viral load > 1000
  --        * Result entered in last three months
  -- Alert: High VL
  -- Do this today: Do adherence counseling intervention
  INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
    SELECT      r.patient_id, 'High VL', 'Do adherence counseling interention'
    FROM        rpt_active_art r
    INNER JOIN  mw_lab_tests t on r.patient_id = t.patient_id
    WHERE       t.lab_test_id = latest_test_result_by_date_entered(r.patient_id, 'Viral Load', null, _endDate, 0)
    AND         t.result_numeric > 1000
    AND         datediff(_endDate, t.date_result_entered) <= 91
  ;


  -- Viral Load Re-test
  -- Logic: 
  --        * High viral load (>1000)
  --        * 60 days between visit after high viral load test and appointment date
  --        * No "bled" recorded on mastercard subsequent to visit after high viral load result
  -- Alert: High VL
  -- Do this today: Consider confirmatory VL
    INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
      SELECT      r.patient_id, 'High VL', 'Consider confirmatory VL'
      FROM        rpt_active_art r
      INNER JOIN  mw_lab_tests t on r.patient_id = t.patient_id
      INNER JOIN  mw_lab_tests t2 on r.patient_id = t.patient_id      
      WHERE       t.lab_test_id = latest_test_result_by_date_entered(r.patient_id, 'Viral Load', null, _endDate, 0)
      AND         t2.lab_test_id = latest_test_result_by_sample_date(r.patient_id, 'Viral Load', null, _endDate, 0)      
      AND         (
                    (
                      t2.date_collected IS NULL
                    )
                    OR
                    (
                      t2.date_collected < t.date_result_entered
                    )
                  )
      AND         t.result_numeric > 1000
      AND         r.last_visit_date > t.date_result_entered
      AND         datediff(_endDate,r.last_visit_date) > 60
    ;


  -- EID Positive Rapid Test
  -- Logic: 
  --        * Last rapid test is positive
  --        * Outcome is still "Exposed Child (continue)"
  -- Alert: EID Positive RT
  -- Do this today: Confirm ART Enrollment
    INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
      SELECT        r.patient_id, 'EID Positive RT', 'Enroll on ART and do DNA-PCR'
      FROM          rpt_active_eid r 
      INNER JOIN    mw_lab_tests t ON t.patient_id = r.patient_id
      WHERE         t.lab_test_id = latest_test_result_by_date_entered(r.patient_id, 'HIV rapid test, qualitative', null, _endDate, 0)
      AND           result_coded = "Positive"
    ;  

  -- EID Positive DNA-PCR
  -- Logic: 
  --        * Last DNA-PCR is positive
  --        * No visit since test result entered
  --        * Outcome is still "Exposed Child (continue)"
  -- Alert: EID Positive DNA-PCR
  -- Do this today: Inform patient, enroll ART, refer to HTC for confirmatory test
    INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
      SELECT        r.patient_id, 'EID Positive DNA-PCR', 'Inform patient, enroll ART, refer to HTC for confirmatory test'
      FROM          rpt_active_eid r 
      INNER JOIN    mw_lab_tests t ON t.patient_id = r.patient_id
      WHERE         t.lab_test_id = latest_test_result_by_date_entered(r.patient_id, 'HIV DNA polymerase chain reaction', null, _endDate, 0)
      AND           result_coded = "Positive"
      AND           last_visit_date <= date_result_entered
    ;  


  -- EID Due for 12 month rapid test
  -- Logic: 
  --        * Age >= 12 months
  --        * No rapid test since 12 months
  -- Alert: Due for EID Rapid Test
  -- Do this today: Refer to HTC for rapid test
    INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
      SELECT        r.patient_id, 'Due for EID Rapid Test', 'Refer to HTC for rapid test'
      FROM        rpt_active_eid r 
      INNER JOIN  mw_patient p on p.patient_id = r.patient_id      
      LEFT JOIN     (SELECT * from 
                      (SELECT * FROM mw_lab_tests 
                        WHERE test_type IN ('HIV rapid test, qualitative','HIV DNA polymerase chain reaction') 
                        ORDER BY date_collected desc) mli 
                        GROUP BY patient_id) t ON t.patient_id = r.patient_id
      WHERE         DATEDIFF(_endDate,p.birthdate) >= 365
      AND         DATEDIFF(_endDate,p.birthdate) < 731
      AND         (DATEDIFF(t.date_result_entered,p.birthdate) < 365 OR t.date_result_entered IS NULL)
    ;    


  -- EID Due for 24 month rapid test
  -- Logic: 
  --        * Age >= 24 months
  --        * No rapid test since 24 months
  -- Alert: Consider EID RT
  -- Do this today: If baby stopped breastfeeding 6w ago, refer to HTC for RT
    INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
      SELECT        r.patient_id, 'Consider EID RT', 'If baby stopped breastfeeding 6w ago, refer to HTC for RT'
      FROM          rpt_active_eid r 
      INNER JOIN    mw_patient p on p.patient_id = r.patient_id      
      LEFT JOIN     (SELECT * from 
                      (SELECT * FROM mw_lab_tests 
                        WHERE test_type IN ('HIV rapid test, qualitative','HIV DNA polymerase chain reaction') 
                        ORDER BY date_collected desc) mli 
                    GROUP BY patient_id) t ON t.patient_id = r.patient_id
      WHERE         DATEDIFF(_endDate,p.birthdate) >= 731
      AND           (DATEDIFF(t.date_result_entered,p.birthdate) < 731 OR t.date_result_entered IS NULL)
    ;  

  -- Diabetes Test Needed
  -- Logic: 
  --        * Diabetes (or Type 2 diabetes) diagnosis and no test in last 6 months
  --        * Type 1 diabetes diagnosis and no test in last 3 months
  -- Alert: Test for HbA1C
  -- Do this today: Refer for fingerstick
    INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
      SELECT       r.patient_id, 'Test for HbA1C', 'Refer for fingerstick'
      FROM         rpt_active_ncd r
      JOIN    (SELECT * FROM mw_ncd_diagnoses WHERE diagnosis IN ('Diabetes','Type 1 diabetes','Type 2 diabetes') group by patient_id) d on d.patient_id = r.patient_id
      LEFT JOIN    (SELECT * 
                      FROM (SELECT * 
                              FROM omrs_obs 
                              WHERE concept = "Glycated hemoglobin" 
                              ORDER BY obs_date desc) oi 
                      GROUP BY patient_id) o 
                      ON o.patient_id = r.patient_id
      WHERE   ( 
                diagnosis = 'Type 1 diabetes' AND (datediff(_endDate,obs_date) > 90 OR obs_date IS NULL)
              )
                OR
              ( 
                diagnosis in ('Diabetes','Type 2 diabetes') AND (datediff(_endDate,obs_date) > 182 OR obs_date IS NULL)
              )             
    ;  

  -- Creatinine test for HTN and DM
  -- Logic: 
  --        * No creatinine result in the last year
  --        * Diagnosis of HTN or DM
  -- Alert: Test for Creatinine
  -- Do this today: Refer to nurse for creatinine test
    INSERT INTO   rpt_appt_alerts(patient_id, alert, action)
      SELECT      r.patient_id, 'Test for Creatinine', 'Refer to nurse for creatinine test'
      FROM        rpt_active_ncd r
      INNER JOIN  (SELECT * FROM mw_ncd_diagnoses d WHERE diagnosis IN ("Diabetes","Hypertension") GROUP BY patient_id) d on d.patient_id = r.patient_id
      LEFT JOIN   (SELECT * 
                    FROM (SELECT * 
                            FROM omrs_obs 
                            WHERE concept = "Creatinine" 
                            ORDER BY obs_date desc) oi 
                            GROUP BY patient_id) o 
                            ON o.patient_id = r.patient_id
      WHERE         (datediff(_endDate,obs_date) > 365 OR obs_date IS NULL)
    ;

END
