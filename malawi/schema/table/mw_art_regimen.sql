
CREATE TABLE mw_art_regimen (
  patient_id           INT NOT NULL,
  regimen			   VARCHAR(255),
  regimen_init_date    DATE,
  num_of_prev_regimens INT,
  regimen_end_date	   DATE,
  line			       VARCHAR(100)
);
