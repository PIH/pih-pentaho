-- Create metric dimension

DROP TABLE IF EXISTS dim_metric;

CREATE TABLE dim_metric (
  metric_id INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(50),
  name VARCHAR(100)
);

INSERT INTO dim_metric (type, name)
    SELECT distinct 'numeric_obs', concept from omrs_obs where value_numeric is not null
;

ALTER TABLE dim_metric ADD INDEX dim_metric_name_idx (name);
