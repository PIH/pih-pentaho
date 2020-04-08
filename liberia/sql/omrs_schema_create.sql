
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

-- adjusted this
CREATE TABLE omrs_program_enrollment (
  program_enrollment_id INT not null,
  patient_id INT not null,
  program_id INT not null,
  program_name VARCHAR(100) not null,
  date_enrolled date not null,
  date_completed date,
  location_id INT,
  location_name VARCHAR(255),
  outcome_concept_id INT,
  outcome_concept_name VARCHAR(255),
  creator VARCHAR(100),
  date_created date,
  changed_by VARCHAR (100),
  date_changed date,
  voided BOOLEAN,
  voided_by VARCHAR(100),
  date_voided date,
  void_reason varchar(255),
  uuid CHAR(38) not null
);

-- mental health encounter table
CREATE TABLE mh_encounter (
encounter_id INT,
patient_id INT,
encounter_datetime DATETIME,
visit_id INT,
referred_by_teacher BOOLEAN,
referred_by_traditional_healer BOOLEAN,
referred_by_vhw BOOLEAN,
referred_by_religious_institution BOOLEAN,
referred_by_self BOOLEAN,
referred_by_oms BOOLEAN,
referral_role_doctor BOOLEAN,
referral_role_nurse BOOLEAN,
referral_role_sws BOOLEAN,
hospitalized_since_last_visit VARCHAR(255),
phq_9 DOUBLE,
pregnant BOOLEAN,
history_alcohol_use VARCHAR(255),
history_drug_use VARCHAR(255),
intervention_supportive_psychotherapy BOOLEAN,
intervention_psychotherapy BOOLEAN,
intervention_psychoeducation BOOLEAN,
intervention_relaxation BOOLEAN,
intervention_family_support BOOLEAN,
intervention_grief_counseling BOOLEAN,
intervention_parenting_skills BOOLEAN,
intervention_behavioral_activation BOOLEAN,
intervention_security_plan BOOLEAN,
intervention_psychosocial_counseling BOOLEAN,
intervention_hiv_counseling BOOLEAN,
intervention_ipod BOOLEAN,
sea_received_financial_aid BOOLEAN,
sea_recommended_financial_aid BOOLEAN,
sea_received_transport_assistance BOOLEAN,
sea_recommended_transport_assistance BOOLEAN,
sea_received_nutritional_assistance BOOLEAN,
sea_recommended_nutritional_assistance BOOLEAN,
sea_received_school_assistance BOOLEAN,
sea_recommended_school_assistance BOOLEAN,
sea_received_housing_assistance BOOLEAN,
sea_recommended_housing_assistance BOOLEAN,
return_visit_date DATETIME
);

-- omrs statistics table
CREATE TABLE omrs_program_statistics (
name VARCHAR(255),
concept_id INT,
ever_enrolled BOOLEAN,
completed_treatment BOOLEAN,
transferred_out BOOLEAN,
dead BOOLEAN,
lost_to_followup BOOLEAN,
patient_refused_treatment BOOLEAN
);


-- omrs rx_prescriptions table
CREATE TABLE omrs_rx_prescriptions (
obs_group_id INT,
encounter_id INT not null,
patient_id INT not null,
encounter_type_id INT,
encounter_type VARCHAR(50),
rx_medication varchar(255),
rx_prescription_quantity DOUBLE,
rx_dose_unit VARCHAR(255),
rx_drug_frequency VARCHAR(255),
rx_medication_duration DOUBLE,
rx_time_units VARCHAR(255)
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
