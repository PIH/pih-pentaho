
-- Create and load the patient dimension
-- TODO: Figure out what put for null values for birth and death dates

DROP TABLE IF EXISTS dim_patient;

CREATE TABLE dim_patient (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_uuid CHAR(38),
  gender CHAR(1),
  birthdate DATE,
  birthdate_id INT,
  dead BOOLEAN,
  death_date DATE,
  death_date_id INT
);

INSERT INTO dim_patient (patient_uuid, gender, birthdate, birthdate_id, dead, death_date, death_date_id)
  SELECT      p.patient_uuid, p.gender, p.birthdate, d1.date_id, p.dead, p.death_date, d2.date_id
  FROM        omrs_patient p
  LEFT JOIN   dim_date d1 ON p.birthdate = d1.full_date
  LEFT JOIN   dim_date d2 ON p.death_date = d2.full_date;

ALTER TABLE dim_patient ADD INDEX dim_patient_uuid_idx (patient_uuid);
ALTER TABLE dim_patient ADD INDEX dim_patient_birthdate_idx (birthdate);