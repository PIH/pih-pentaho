
CREATE TABLE arw_program_enrollment (
  research_program_enrollment_id VARCHAR(32),
  research_patient_id VARCHAR(32),
  program VARCHAR(100) not null,
  enrollment_date date not null,
  age_years_at_enrollment int,
  age_months_at_enrollment int,
  location VARCHAR(255),
  completion_date date,
  age_years_at_completion int,
  age_months_at_completion int,
  outcome varchar(255)
);