
CREATE TABLE mw_lab_tests_recent_period (
  lab_test_id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  patient_id           INT NOT NULL,
  encounter_id		   INT,
  date_collected       DATE,
  test_type            VARCHAR(100),
  date_result_received DATE,
  date_result_entered  DATE,
  result_coded         VARCHAR(100),
  result_numeric       DECIMAL(10,2),
  result_exception     VARCHAR(100),
  end_date			   DATE
);
alter table mw_lab_tests add index mw_lab_tests_recent_idx (patient_id);
