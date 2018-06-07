CREATE TABLE omrs_encounter
(
  encounter_id INT
, uuid VARCHAR(38)
, patient_id INT
, encounter_type VARCHAR(255)
, form VARCHAR(255)
, location VARCHAR(255)
, encounter_date DATETIME
, encounter_time DATETIME
, provider VARCHAR(255)
, provider_role VARCHAR(255)
, age_years_at_encounter INT
, age_months_at_encounter INT
, date_created DATETIME
, created_by VARCHAR(100)
)
;

CREATE TABLE omrs_encounter_provider
(
  encounter_provider_id INT
, uuid VARCHAR(38)
, encounter_id INT
, encounter_uuid VARCHAR(38)
, provider VARCHAR(255)
, provider_role VARCHAR(255)
)
;

CREATE TABLE omrs_obs
(
  obs_id INT
, uuid VARCHAR(38)
, patient_id INT
, encounter_id INT
, obs_date DATETIME
, obs_time DATETIME
, age_years_at_obs INT
, age_months_at_obs INT
, encounter_type VARCHAR(255)
, location VARCHAR(255)
, concept VARCHAR(255)
, value_coded VARCHAR(255)
, value_date DATETIME
, value_numeric FLOAT(53)
, value_text NVARCHAR(65535)
, comments VARCHAR(255)
, obs_group_id INT
, date_created DATETIME
)
;

CREATE TABLE omrs_obs_group
(
  obs_group_id INT
, uuid VARCHAR(38)
, patient_id INT
, encounter_id INT
, obs_group_date DATETIME
, obs_group_time DATETIME
, encounter_type VARCHAR(255)
, location VARCHAR(255)
, concept VARCHAR(255)
, date_created DATETIME
)
;

CREATE TABLE omrs_patient
(
  patient_id INT
, patient_uuid VARCHAR(38)
, identifier VARCHAR(50)
, first_name VARCHAR(50)
, middle_name VARCHAR(50)
, last_name VARCHAR(50)
, gender VARCHAR(1)
, birthdate DATETIME
, birthdate_estimated BIT
, phone_number VARCHAR(50)
, country VARCHAR(50)
, state_province VARCHAR(255)
, county_district VARCHAR(255)
, city_village VARCHAR(255)
, postal_code VARCHAR(50)
, address1 VARCHAR(255)
, address2 VARCHAR(255)
, address3 VARCHAR(255)
, address4 VARCHAR(255)
, address5 VARCHAR(255)
, address6 VARCHAR(255)
, latitude VARCHAR(50)
, longitude VARCHAR(50)
, dead BIT
, death_date DATETIME
, age_years_at_death INT
, age_months_at_death INT
, cause_of_death VARCHAR(255)
, mothers_name VARCHAR(50)
, fathers_name VARCHAR(50)
, health_center VARCHAR(255)
, date_created DATETIME
)
;

CREATE TABLE omrs_patient_identifier
(
  patient_identifier_id INT
, uuid VARCHAR(38)
, patient_id INT
, type VARCHAR(50)
, identifier VARCHAR(50)
, location VARCHAR(255)
, date_created DATETIME
)
;

CREATE TABLE omrs_program_enrollment
(
  program_enrollment_id INT
, uuid VARCHAR(38)
, patient_id INT
, program VARCHAR(100)
, enrollment_date DATETIME
, age_years_at_enrollment INT
, age_months_at_enrollment INT
, location VARCHAR(255)
, completion_date DATETIME
, age_years_at_completion INT
, age_months_at_completion INT
, outcome VARCHAR(255)
)
;

CREATE TABLE omrs_program_state
(
  program_state_id INT
, uuid VARCHAR(38)
, program_enrollment_id INT
, patient_id INT
, program VARCHAR(100)
, workflow VARCHAR(100)
, "state" VARCHAR(100)
, start_date DATETIME
, age_years_at_start INT
, age_months_at_start INT
, end_date DATETIME
, age_years_at_end INT
, age_months_at_end INT
, location VARCHAR(255)
)
;

CREATE TABLE omrs_relationship
(
  relationship_id INT
, uuid VARCHAR(38)
, patient_id INT
, patient_role VARCHAR(50)
, related_person_role VARCHAR(50)
, related_person VARCHAR(255)
, start_date DATETIME
, end_date DATETIME
, date_created DATETIME
)
;

CREATE TABLE omrs_visit
(
  visit_id INT
, uuid VARCHAR(38)
, patient_id INT
, visit_type VARCHAR(255)
, location VARCHAR(255)
, date_started DATETIME
, date_stopped DATETIME
, date_created DATETIME
)
;



