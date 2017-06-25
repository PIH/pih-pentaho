
create table mw_ncd_diagnoses (
  patient_id     INT          NOT NULL,
  diagnosis      VARCHAR(100) NOT NULL,
  diagnosis_date DATE         NOT NULL
);
alter table mw_ncd_diagnoses add index mw_ncd_diagnoses_patient_idx (patient_id);