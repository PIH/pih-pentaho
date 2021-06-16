CREATE TABLE mw_art_viral_load (
  viral_load_visit_id 		int NOT NULL AUTO_INCREMENT,
  patient_id 			int NOT NULL,
  visit_date 			date DEFAULT NULL,
  location 			varchar(255) DEFAULT NULL,
  reason_for_test		varchar(255) DEFAULT NULL,
  lab_location 		varchar(255) DEFAULT NULL,
  bled 			varchar(255) DEFAULT NULL,
  sample_id 			varchar(255) DEFAULT NULL,
  viral_load_result 		int DEFAULT NULL,
  less_than_limit 		int DEFAULT NULL,
  ldl 				varchar(255) DEFAULT NULL,
  other_results 		varchar(255) DEFAULT NULL,
  PRIMARY KEY (viral_load_visit_id)
);
