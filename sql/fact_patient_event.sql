-- Patient event fact table.  Dependent upon creation on the necessary linked dimension tables

DROP TABLE IF EXISTS fact_patient_event;

CREATE TABLE fact_patient_event (
  patient_id INT,
  gender_id INT,
  age_id INT,
  date_id INT,
  time_id INT,
  location_id INT,
  program_id INT,
  encounter_type_id INT,
  metric_id INT,
  value DOUBLE
);

