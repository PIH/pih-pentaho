-- Create coded value dimension

DROP TABLE IF EXISTS dim_coded_value;

CREATE TABLE dim_coded_value (
  coded_value_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO dim_coded_value (name)
    SELECT distinct value_coded from omrs_obs where value_coded is not null
;

ALTER TABLE dim_coded_value ADD INDEX dim_coded_value_name_idx (name);
