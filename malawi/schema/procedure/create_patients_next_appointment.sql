/************************************************************************
  Get all patients (PID) with appointment dates for a given enrollment location
  for EID, ART, and NCD programs.
*************************************************************************/
CREATE PROCEDURE create_patients_next_appointment(IN _location VARCHAR(255))
  BEGIN

    DROP TEMPORARY TABLE IF EXISTS patients_next_appointment;
    CREATE TEMPORARY TABLE patients_next_appointment (
      patient_id        INT NOT NULL,
      last_visit_date DATE,
      last_appt_date    DATE
    );
    CREATE INDEX patients_next_appointment_id_idx ON patients_next_appointment(patient_id);

    INSERT INTO patients_next_appointment (patient_id, last_visit_date, last_appt_date)
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
                              ) r
                           ON r.patient_id = v.patient_id
                       WHERE next_appointment_date IS NOT NULL
                       ORDER BY visit_date desc
                     ) itable
               GROUP BY patient_id
             ) appt_temp;

  END
