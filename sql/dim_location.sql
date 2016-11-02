-- Create location dimension

DROP TABLE IF EXISTS dim_location;

create table dim_location (
  location_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

insert into dim_location (name)
    select distinct(target_value) from lookup_location order by target_value
;

ALTER TABLE dim_location ADD INDEX dim_location_name_idx (name);
