-- Create age dimension
-- TODO: We should represent "unknown" as an entry in this table somehow, to avoid null values in the fact table

DROP TABLE IF EXISTS dim_age;

create table dim_age (
  age_id INT AUTO_INCREMENT PRIMARY KEY,
  full_years INT,
  full_months INT
);

insert into dim_age (full_years, full_months)
  select distinct yrs, mths from
  (SELECT age_years_at_death as yrs, age_months_at_death mths FROM omrs_patient where age_months_at_death is not null
   UNION
   SELECT age_years_at_enrollment, age_months_at_enrollment FROM omrs_program_enrollment where age_months_at_enrollment is not null
   UNION
   SELECT age_years_at_completion, age_months_at_completion FROM omrs_program_enrollment where age_months_at_enrollment is not null
   UNION
   SELECT age_years_at_start, age_months_at_start FROM omrs_program_state where age_months_at_start is not null
   UNION
   SELECT age_years_at_end, age_months_at_end FROM omrs_program_state where age_months_at_end is not null
   UNION
   SELECT age_years_at_encounter, age_months_at_encounter FROM omrs_encounter where age_months_at_encounter is not null
   UNION
   SELECT age_years_at_obs, age_months_at_obs FROM omrs_obs where age_months_at_obs is not null
  ) d
;

ALTER TABLE dim_age ADD INDEX dim_age_years_idx (full_years);
ALTER TABLE dim_age ADD INDEX dim_age_months_idx (full_months);