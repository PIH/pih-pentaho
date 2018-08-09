CREATE TABLE rw_pdc_malnutrition_program (
  program_enrollment_id INT,
  uuid CHAR(38),
  patient_id INT not null,
  program VARCHAR(100),
  enrollment_date date,
  age_years_at_enrollment int,
  age_months_at_enrollment int,
  location VARCHAR(255),
  completion_date date,
  age_years_at_completion int,
  age_months_at_completion int,
  outcome varchar(255)
);