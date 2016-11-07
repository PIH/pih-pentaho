-- Create numeric question dimension

DROP TABLE IF EXISTS dim_numeric_question;

CREATE TABLE dim_numeric_question (
  numeric_question_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO dim_numeric_question (name)
    SELECT distinct concept from omrs_obs where value_numeric is not null
;

ALTER TABLE dim_numeric_question ADD INDEX dim_numeric_question_name_idx (name);
