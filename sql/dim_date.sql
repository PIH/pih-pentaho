-- Create date dimension
-- TODO: We should represent "unknown" as an entry in this table somehow, to avoid null values in the fact table

DROP TABLE IF EXISTS dim_date;

create table dim_date (
  date_id INT AUTO_INCREMENT PRIMARY KEY,
  full_date DATE,
  year INT,
  month INT,
  day INT
);

insert into dim_date (full_date, month, year, day)
  select distinct d.selected_date, year(d.selected_date), month(d.selected_date), day(d.selected_date) from
  (SELECT DISTINCT birthdate as selected_date FROM omrs_patient
   UNION
   SELECT DISTINCT death_date FROM omrs_patient
   UNION
   SELECT DISTINCT enrollment_date FROM omrs_program_enrollment
   UNION
   SELECT DISTINCT completion_date FROM omrs_program_enrollment
   UNION
   SELECT DISTINCT start_date FROM omrs_program_state
   UNION
   SELECT DISTINCT end_date FROM omrs_program_state
   UNION
   SELECT DISTINCT date(encounter_datetime) FROM omrs_encounter
   UNION
   SELECT DISTINCT date(obs_datetime) FROM omrs_obs
   UNION
   SELECT DISTINCT date(value_datetime) FROM omrs_obs
  ) d
;

ALTER TABLE dim_date ADD INDEX dim_date_full_date_idx (full_date);
