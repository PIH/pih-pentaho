CREATE TABLE mw_eid_followup (
  eid_followup_visit_id int NOT NULL AUTO_INCREMENT,
  patient_id int NOT NULL,
  visit_date date DEFAULT NULL,
  location varchar(255) DEFAULT NULL,
  muac double DEFAULT NULL,
  wasting_or_malnutrition varchar(255) DEFAULT NULL,
  breast_feeding varchar(255) DEFAULT NULL,
  mother_status varchar(255) DEFAULT NULL,
  clinical_monitoring varchar(255) DEFAULT NULL,
  hiv_infection varchar(255) DEFAULT NULL,
  cpt int DEFAULT NULL,
  next_appointment_date date DEFAULT NULL,
  PRIMARY KEY (eid_followup_visit_id)
);
