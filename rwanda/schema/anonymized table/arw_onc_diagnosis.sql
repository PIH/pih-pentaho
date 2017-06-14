
CREATE TABLE arw_onc_diagnosis (
  research_program_state_id BIGINT not null,
  research_diagnosis_status_program_enrollment_id BIGINT,
  research_program_enrollment_id BIGINT not null,
  research_patient_id BIGINT not null,
  research_diagnosis_status_patient_id BIGINT,
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

