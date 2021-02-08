
-- Schema used to set up liberia specific tables

-- program enrollment table
CREATE TABLE program_enrollment (
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

-- mental-health encounter table
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

-- program statistics table
CREATE TABLE program_statistics (
name VARCHAR(255),
concept_id INT,
ever_enrolled BOOLEAN,
completed_treatment BOOLEAN,
transferred_out BOOLEAN,
dead BOOLEAN,
lost_to_followup BOOLEAN,
patient_refused_treatment BOOLEAN
);


-- rx_prescriptions table
CREATE TABLE rx_prescriptions (
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
