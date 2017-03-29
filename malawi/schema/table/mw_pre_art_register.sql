
CREATE TABLE mw_pre_art_register (
  enrollment_id  INT NOT NULL,
  patient_id     INT NOT NULL,
  location       VARCHAR(255),
  pre_art_number VARCHAR(50),
  start_date     DATE,
  end_date       DATE,
  outcome        VARCHAR(100)
);
alter table mw_pre_art_register add index mw_pre_art_register_patient_idx (patient_id);
alter table mw_pre_art_register add index mw_pre_art_register_patient_location_idx (patient_id, location);