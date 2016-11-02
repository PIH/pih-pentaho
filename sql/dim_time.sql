-- Time dimension
-- TODO: We should represent "unknown" as an entry in this table somehow, to avoid null values in the fact table

DROP TABLE IF EXISTS dim_time;

create table dim_time (
  time_id INT AUTO_INCREMENT PRIMARY KEY,
  full_time TIME,
  hour INT,
  minute INT,
  second INT
);

insert into dim_time (full_time, hour, minute, second)
  SELECT DISTINCT d.selected_time, hour(d.selected_time), minute(d.selected_time), second(d.selected_time) FROM
    (SELECT encounter_time as selected_time FROM omrs_encounter
     UNION
     SELECT obs_time FROM omrs_obs
    ) d
;

ALTER TABLE dim_time ADD INDEX dim_full_time_idx (full_time);