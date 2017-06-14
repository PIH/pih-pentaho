CREATE TABLE mw_eid_register (
  enrollment_id                    INT NOT NULL,
  patient_id                       INT NOT NULL,
  location                         VARCHAR(255),
  eid_number                       VARCHAR(50),
  start_date                       DATE,
  end_date                         DATE,
  outcome                          VARCHAR(100),
  last_eid_visit_id                INT
);
alter table mw_eid_register add index mw_eid_register_patient_idx (patient_id);
alter table mw_eid_register add index mw_eid_register_patient_location_idx (patient_id, location);