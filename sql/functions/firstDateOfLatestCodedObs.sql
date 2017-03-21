/*
	Extract date on which patient first stopped breastfeeding over 6 weeks ago
	For all patients in the register, first recorded breastfeeding status obs date, if the value is stopped over 6 weeks ago,
	and after any other different status is recorded
*/
SELECT
  r.patient_id,
  r.location,
  fs.first_6_wk_status_date as breastfeeding_stopped_over_6_weeks_date
FROM
  mw_eid_register r

  LEFT JOIN (
              SELECT
                v.patient_id,
                v.location,
                min(v.visit_date) AS first_6_wk_status_date,
                ls.last_non_6_wk_status_date
              FROM mw_eid_visits v

                LEFT JOIN (
                            SELECT
                              v1.patient_id,
                              v1.location,
                              max(v1.visit_date) AS last_non_6_wk_status_date
                            FROM mw_eid_visits v1
                            WHERE v1.breastfeeding_status != 'Breastfeeding stopped over 6 weeks ago'
                            GROUP BY v1.patient_id, v1.location
                          )
                          ls ON v.patient_id = ls.patient_id AND v.location = ls.location

              WHERE v.breastfeeding_status = 'Breastfeeding stopped over 6 weeks ago'
                    AND ( ls.last_non_6_wk_status_date IS NULL OR v.visit_date >= ls.last_non_6_wk_status_date )
              GROUP BY v.patient_id, v.location
            )
            fs ON r.patient_id = fs.patient_id AND r.location = fs.location

ORDER BY r.patient_id, r.location