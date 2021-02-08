
CREATE TABLE mw_patient (
  patient_id            INT NOT NULL,
  identifier            VARCHAR(50),
  first_name            VARCHAR(50),
  last_name             VARCHAR(50),
  gender                CHAR(1),
  birthdate             DATE,
  birthdate_estimated   BOOLEAN,
  phone_number          VARCHAR(50),
  district              VARCHAR(255),
  traditional_authority VARCHAR(255),
  village               VARCHAR(255),
  chw                   VARCHAR(100),
  dead                  BOOLEAN,
  death_date            DATE,
  patient_uuid	 	 CHAR(38)
);
alter table mw_patient add index mw_patient_id_idx (patient_id);
