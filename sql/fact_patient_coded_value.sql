-- Patient coded value fact table.  Dependent upon creation on the necessary linked dimension tables

DROP TABLE IF EXISTS fact_patient_coded_value;

CREATE TABLE fact_patient_coded_value (
  patient_id INT,
  gender_id INT,
  age_id INT,
  date_id INT,
  time_id INT,
  location_id INT,
  program_id INT,
  encounter_type_id INT,
  coded_question_id INT,
  coded_value_id INT
);
