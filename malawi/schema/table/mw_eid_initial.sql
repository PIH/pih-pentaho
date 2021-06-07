CREATE TABLE mw_eid_initial (
  eid_initial_visit_id int NOT NULL AUTO_INCREMENT,
  patient_id int NOT NULL,
  visit_date date DEFAULT NULL,
  location varchar(255) DEFAULT NULL,
  mother_hiv_status varchar(255) DEFAULT NULL,
  mother_art_reg_no varchar(255) DEFAULT NULL,
  mother_art_start_date date DEFAULT NULL,
  age int DEFAULT NULL,
  age_when_starting_nvp int DEFAULT NULL,
  duration_type_when_starting_nvp varchar(255) DEFAULT NULL,
  nvp_duration int DEFAULT NULL,
  nvp_duration_type varchar(255) DEFAULT NULL,
  birth_weight decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (eid_initial_visit_id)
);
