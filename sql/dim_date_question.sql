-- Create date question dimension

DROP TABLE IF EXISTS dim_date_question;

CREATE TABLE dim_date_question (
  date_question_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO dim_date_question (name)
    SELECT distinct concept from omrs_obs where value_date is not null
;

ALTER TABLE dim_date_question ADD INDEX dim_date_question_name_idx (name);
