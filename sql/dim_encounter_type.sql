-- Create program dimension

DROP TABLE IF EXISTS dim_encounter_type;

create table dim_encounter_type (
  encounter_type_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

insert into dim_encounter_type (name)
    select distinct(encounter_type) from omrs_encounter order by encounter_type
;

ALTER TABLE dim_encounter_type ADD INDEX dim_encounter_type_name_idx (name);
