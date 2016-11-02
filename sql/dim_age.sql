-- Create age dimension
-- TODO: We should represent "unknown" as an entry in this table somehow, to avoid null values in the fact table

DROP TABLE IF EXISTS dim_age;

create table dim_age (
  age_id INT AUTO_INCREMENT PRIMARY KEY,
  birthdate DATE,
  age_date DATE,
  full_years INT,
  full_months INT
);

insert into dim_age (birthdate, age_date, full_years, full_months)
  select distinct d.birthdate, d.age_date, TIMESTAMPDIFF(YEAR, d.birthdate, d.age_date), TIMESTAMPDIFF(MONTH, d.birthdate, d.age_date) from
  (SELECT birthdate, death_date as age_date FROM dim_patient where death_date is not null
   UNION
   SELECT p.birthdate, e.enrollment_date FROM omrs_patient p inner join omrs_program_enrollment e on p.uuid = e.patient_uuid where p.birthdate is not null
   UNION
   SELECT p.birthdate, e.completion_date FROM omrs_patient p inner join omrs_program_enrollment e on p.uuid = e.patient_uuid where p.birthdate is not null
   UNION
   SELECT p.birthdate, e.start_date FROM omrs_patient p inner join omrs_program_state e on p.uuid = e.patient_uuid where p.birthdate is not null
   UNION
   SELECT p.birthdate, e.end_date FROM omrs_patient p inner join omrs_program_state e on p.uuid = e.patient_uuid where p.birthdate is not null
   UNION
   SELECT p.birthdate, date(e.encounter_datetime) FROM omrs_patient p inner join omrs_encounter e on p.uuid = e.patient_uuid where p.birthdate is not null
   UNION
   SELECT p.birthdate, date(obs_datetime) FROM omrs_patient p inner join omrs_obs e on p.uuid = e.patient_uuid where p.birthdate is not null
   UNION
   SELECT p.birthdate, date(value_datetime) FROM omrs_patient p inner join omrs_obs e on p.uuid = e.patient_uuid where p.birthdate is not null
  ) d
;

ALTER TABLE dim_age ADD INDEX dim_age_birthdate_idx (birthdate);
ALTER TABLE dim_age ADD INDEX dim_age_agedate_idx (age_date);