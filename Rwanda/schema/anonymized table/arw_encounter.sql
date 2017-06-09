
CREATE TABLE arw_encounter (
  research_encounter_id VARCHAR(32),
  research_patient_id VARCHAR(32),
  encounter_type VARCHAR(255) not null,
  form VARCHAR(255),
  location VARCHAR(255),
  encounter_date date,
  encounter_time time,
  age_years_at_encounter INT,
  age_months_at_encounter INT,
  date_created DATE
);