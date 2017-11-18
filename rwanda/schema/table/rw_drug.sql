
CREATE TABLE rw_onc_diagnosis (
  program_state_id varchar(32) not null,
  diagnosis_status_program_enrollment_id varchar(32),
  uuid varchar(64) not null,
  program_enrollment_id varchar(32) not null,
  patient_id varchar(32) not null,
  diagnosis_status_patient_id varchar(32),
  program VARCHAR(100) not null,
  diagnosis_status_program VARCHAR(100),
  workflow VARCHAR(100) not null,
  diagnosis_status_workflow VARCHAR(100),
  state VARCHAR(100) not null,
  diagnosis_status VARCHAR(100),
  start_date date not null,
  diagnosis_status_start_date date,
  age_years_at_start int,
  age_months_at_start int,
  end_date date,
  diagnosis_status_end_date date,
  age_years_at_end int,
  age_months_at_end int,
  location VARCHAR(255),
  start_date_difference fLOAT,
  end_date_difference FLOAT
);

alter table rw_onc_diagnosis add index rw_onc_diagnosis_program_state_id(program_state_id);
