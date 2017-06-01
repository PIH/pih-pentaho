
CREATE TABLE arw_obs (
  research_obs_id BIGINT not null,
  research_patient_id INT not null,
  research_encounter_id INT,
  obs_date date,
  obs_time time,
  age_years_at_obs INT,
  age_months_at_obs INT,
  encounter_type VARCHAR(255),
  location VARCHAR(255),
  concept VARCHAR(255) not null,
  value_coded VARCHAR(255),
  value_date DATE DEFAULT NULL,
  value_numeric DOUBLE DEFAULT NULL,
  value_text TEXT,
  comments VARCHAR(255),
  obs_group_id INT,
  date_created DATE
);