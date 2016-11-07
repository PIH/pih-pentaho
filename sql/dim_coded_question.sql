-- Create coded question dimension

DROP TABLE IF EXISTS dim_coded_question;

CREATE TABLE dim_coded_question (
  coded_question_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO dim_coded_question (name)
    SELECT distinct concept from omrs_obs where value_coded is not null
;

ALTER TABLE dim_coded_question ADD INDEX dim_coded_question_name_idx (name);
