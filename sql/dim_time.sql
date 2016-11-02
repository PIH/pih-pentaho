-- Time dimension
-- TODO: We should represent "unknown" as an entry in this table somehow, to avoid null values in the fact table

DROP TABLE IF EXISTS dim_time;

create table dim_time (
  time_id INT AUTO_INCREMENT PRIMARY KEY,
  hour INT,
  minute INT
);

insert into dim_time (hour, minute)
  SELECT DISTINCT hour(d.selected_date), minute(d.selected_date) FROM
    (SELECT encounter_datetime as selected_date FROM omrs_encounter
     UNION
     SELECT obs_datetime FROM omrs_obs
     UNION
     SELECT value_datetime FROM omrs_obs
    ) d
;
