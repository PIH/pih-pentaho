
CREATE TABLE mw_art_register (
  enrollment_id             INT NOT NULL,
  patient_id                INT NOT NULL,
  location                  VARCHAR(255),
  art_number                VARCHAR(50),
  start_date                DATE,
  end_date                  DATE,
  outcome                   VARCHAR(100),
  last_art_visit_id         INT,
  last_viral_load_test_id   INT,
  last_viral_load_result_id INT
);
alter table mw_art_register add index mw_art_register_patient_idx (patient_id);
alter table mw_art_register add index mw_art_register_patient_location_idx (patient_id, location);