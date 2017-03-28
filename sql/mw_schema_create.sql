
-- Schema used to set up the mw_* tables for transformed OpenMRS Malawi data

CREATE TABLE mw_patient (
  patient_id            INT NOT NULL,
  identifier            VARCHAR(50),
  first_name            VARCHAR(50),
  last_name             VARCHAR(50),
  gender                CHAR(1),
  birthdate             DATE,
  birthdate_estimated   BOOLEAN,
  phone_number          VARCHAR(50),
  district              VARCHAR(255),
  traditional_authority VARCHAR(255),
  village               VARCHAR(255),
  vhw                   VARCHAR(100),
  dead                  BOOLEAN,
  death_date            DATE
);

CREATE TABLE mw_lab_tests (
  lab_test_id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  patient_id           INT NOT NULL,
  date_collected       DATE,
  test_type            VARCHAR(100),
  date_result_received DATE,
  date_result_entered  DATE,
  result_coded         VARCHAR(100),
  result_numeric       DOUBLE,
  result_exception     VARCHAR(100)
);

CREATE TABLE mw_eid_visits (
  eid_visit_id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  patient_id            INT NOT NULL,
  visit_date            DATE,
  location              VARCHAR(255),
  breastfeeding_status  VARCHAR(100),
  next_appointment_date DATE
);

CREATE TABLE mw_eid_register (
  enrollment_id                    INT NOT NULL,
  patient_id                       INT NOT NULL,
  location                         VARCHAR(255),
  eid_number                       VARCHAR(50),
  start_date                       DATE,
  end_date                         DATE,
  outcome                          VARCHAR(100),
  last_eid_visit_id                INT
);

CREATE TABLE mw_pre_art_visits (
  pre_art_visit_id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  patient_id            INT NOT NULL,
  visit_date            DATE,
  location              VARCHAR(255),
  next_appointment_date DATE
);

CREATE TABLE mw_pre_art_register (
  enrollment_id             INT NOT NULL,
  patient_id                INT NOT NULL,
  location                  VARCHAR(255),
  hcc_number                VARCHAR(50),
  start_date                DATE,
  end_date                  DATE,
  outcome                   VARCHAR(100)
);

CREATE TABLE mw_art_visits (
  art_visit_id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  patient_id            INT NOT NULL,
  visit_date            DATE,
  location              VARCHAR(255),
  next_appointment_date DATE
);

CREATE TABLE mw_art_register (
  enrollment_id             INT NOT NULL,
  patient_id                INT NOT NULL,
  location                  VARCHAR(255),
  art_number                VARCHAR(50),
  start_date                DATE,
  end_date                  DATE,
  outcome                   VARCHAR(100),
  last_art_visit_id         INT,
  last_viral_load_test_id   INT,
  last_viral_load_result_id INT
);

create table mw_ncd_diagnoses (
  patient_id     INT          NOT NULL,
  diagnosis      VARCHAR(100) NOT NULL,
  diagnosis_date DATE         NOT NULL
);

create table mw_ncd_visits (
  ncd_visit_id           INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  patient_id             INT NOT NULL,
  visit_date             DATE,
  location               VARCHAR(255),
  visit_types            VARCHAR(255),
  cc_initial             BOOLEAN,
  cc_followup            BOOLEAN,
  diabetes_htn_initial   BOOLEAN,
  diabetes_htn_followup  BOOLEAN,
  asthma_initial         BOOLEAN,
  asthma_followup        BOOLEAN,
  epilepsy_initial       BOOLEAN,
  epilepsy_followup      BOOLEAN,
  mental_health_initial  BOOLEAN,
  mental_health_followup BOOLEAN,
  next_appointment_date  DATE,
  systolic_bp            DOUBLE,
  diastolic_bp           DOUBLE,
  on_insulin             BOOLEAN,
  asthma_classification  VARCHAR(100),
  num_seizures           DOUBLE
);

create table mw_ncd_register (
  enrollment_id INT NOT NULL,
  patient_id    INT NOT NULL,
  location      VARCHAR(255),
  ncd_number    VARCHAR(50),
  start_date    DATE,
  end_date      DATE,
  outcome       VARCHAR(100)
);
