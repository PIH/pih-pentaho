
CREATE TABLE arw_program_state (
  research_program_state_id VARCHAR(32),
  research_program_enrollment_id VARCHAR(32),
  research_patient_id VARCHAR(32),
  program VARCHAR(100) not null,
  workflow VARCHAR(100) not null,
  state VARCHAR(100) not null,
  start_date date not null,
  age_years_at_start int,
  age_months_at_start int,
  end_date date,
  age_years_at_end int,
  age_months_at_end int,
  location VARCHAR(255)
);