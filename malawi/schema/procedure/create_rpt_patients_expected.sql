/************************************************************************
  Get all patients (PID) with appointment date for a given enrollment location 
  and within given window for EID, ART, and NCD programs. 
*************************************************************************/
CREATE PROCEDURE create_rpt_patients_expected(IN _startDate DATE, IN _endDate DATE, IN _location VARCHAR(255), IN _advancedCare TINYINT) BEGIN

  DROP TEMPORARY TABLE IF EXISTS rpt_patients_expected;
  CREATE TEMPORARY TABLE rpt_patients_expected (
    patient_id        INT NOT NULL,
    last_visit_date DATE,
    last_appt_date    DATE
  );
  CREATE INDEX rpt_patients_expected_id_idx ON rpt_patients_expected(patient_id);

  INSERT INTO rpt_patients_expected (patient_id, last_visit_date, last_appt_date)
  SELECT patient_id, visit_date, next_appointment_date
  FROM   ( 
          -- sub-query to get the latest appointment date (from last visit)
          SELECT * 
          FROM  (
                -- three joined sub-queries to get all appointment dates (from EID, NCD, & ART)
                SELECT v.patient_id, v.visit_date, v.next_appointment_date, r.location 
                FROM mw_art_visits v
                JOIN (
                      SELECT patient_id, location
                      FROM mw_art_register 
                      WHERE location = _location
                      and (end_date IS NULL OR end_date > _endDate)
                    ) r
                ON r.patient_id = v.patient_id          
                WHERE next_appointment_date IS NOT NULL 

                UNION 

                SELECT v.patient_id, v.visit_date, v.next_appointment_date, r.location  
                FROM mw_eid_visits v
                JOIN (
                      SELECT patient_id, location
                      FROM mw_eid_register 
                      WHERE location = _location
                      and (end_date IS NULL OR end_date > _endDate)
                    ) r
                ON r.patient_id = v.patient_id  
                WHERE next_appointment_date IS NOT NULL

                UNION

                SELECT v.patient_id, v.visit_date, v.next_appointment_date, r.location  
                FROM mw_ncd_visits v          
                JOIN (
                      SELECT patient_id, location
                      FROM mw_ncd_register 
                      WHERE location = _location
                      and (end_date IS NULL OR end_date > _endDate)
                    ) r
                ON r.patient_id = v.patient_id            
                WHERE next_appointment_date IS NOT NULL   
                ORDER BY visit_date desc
          ) itable
        GROUP BY patient_id
        ) appt_temp
  WHERE next_appointment_date >= _startDate
  AND next_appointment_date <= _endDate;   

/*  If the advanced care option is chosen, delete the patients who are
  not in a state of advanced care from the temporary table.
*/
  IF _advancedCare = 1 THEN
    DELETE FROM rpt_patients_expected where patient_id in 
      (select patient_id from 
        (select * from 
          (select * from omrs_program_state order by start_date desc) 
      as itable group by patient_id) otable where state <> "In advanced care");
  END IF;

END