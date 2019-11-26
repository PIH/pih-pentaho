
-- Schema used to set up the omrs_* tables for flattened OpenMRS data

CREATE TABLE omrs_patient (
  patient_id INT not null,
  patient_uuid CHAR(38) not null,
  identifier VARCHAR(50),
  first_name VARCHAR(50),
  middle_name VARCHAR(50),
  last_name VARCHAR(50),
  gender CHAR(1),
  birthdate DATE,
  birthdate_estimated BOOLEAN,
  phone_number VARCHAR(50),
  country VARCHAR(50),
  state_province VARCHAR(255),
  county_district VARCHAR(255),
  city_village VARCHAR(255),
  postal_code VARCHAR(50),
  address1 VARCHAR(255),
  address2 VARCHAR(255),
  address3 VARCHAR(255),
  address4 VARCHAR(255),
  address5 VARCHAR(255),
  address6 VARCHAR(255),
  latitude VARCHAR(50),
  longitude VARCHAR(50),
  dead BOOLEAN,
  death_date DATE,
  age_years_at_death INT,
  age_months_at_death INT,
  cause_of_death VARCHAR(255),
  mothers_name VARCHAR(50),
  fathers_name VARCHAR(50),
  health_center VARCHAR(255),
  date_created DATE
);

CREATE TABLE omrs_patient_identifier (
  patient_identifier_id INT not null,
  uuid CHAR(38) not null,
  patient_id INT not null,
  type VARCHAR(50) not null,
  identifier VARCHAR(50) not null,
  location VARCHAR(255),
  date_created DATE
);

CREATE TABLE omrs_relationship (
  relationship_id INT not null,
  uuid CHAR(38) not null,
  patient_id INT not null,
  patient_role VARCHAR(50) not null,
  related_person_role VARCHAR(50) not null,
  related_person VARCHAR(255),
  start_date DATE,
  end_date DATE,
  date_created DATE
);

CREATE TABLE omrs_encounter_provider (
  encounter_provider_id INT not null,
  uuid CHAR(38) not null,
  encounter_id INT not null,
  encounter_uuid CHAR(38) not null,
  provider VARCHAR(255),
  provider_role VARCHAR(255)
);

CREATE TABLE omrs_encounter (
  encounter_id INT not null,
  uuid CHAR(38) not null,
  patient_id INT not null,
  encounter_type VARCHAR(255) not null,
  form VARCHAR(255),
  location VARCHAR(255),
  encounter_date date,
  encounter_time time,
  provider VARCHAR(255),
  provider_role VARCHAR(255),
  visit_id INT,
  age_years_at_encounter INT,
  age_months_at_encounter INT,
  date_created DATE,
  created_by VARCHAR(100)
);

CREATE TABLE omrs_visit (
  visit_id INT not null,
  uuid CHAR(38) not null,
  patient_id INT not null,
  visit_type VARCHAR(255) not null,
  location VARCHAR(255),
  date_started date,
  date_stopped date,
  date_created DATE
);

CREATE TABLE omrs_obs_group (
  obs_group_id INT not null,
  uuid CHAR(38) not null,
  patient_id INT not null,
  encounter_id INT,
  obs_group_date date,
  obs_group_time time,
  encounter_type VARCHAR(255),
  location VARCHAR(255),
  concept VARCHAR(255) not null,
  date_created DATE
);

CREATE TABLE omrs_obs (
  obs_id INT not null,
  uuid CHAR(38) not null,
  patient_id INT not null,
  encounter_id INT,
  obs_date date,
  obs_time time,
  age_years_at_obs INT,
  age_months_at_obs INT,
  encounter_type VARCHAR(255),
  form VARCHAR(255),
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

CREATE TABLE omrs_program_enrollment (
  program_enrollment_id INT not null,
  uuid CHAR(38) not null,
  patient_id INT not null,
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

CREATE TABLE omrs_program_state (
  program_state_id INT not null,
  uuid CHAR(38) not null,
  program_enrollment_id INT not null,
  patient_id INT not null,
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
