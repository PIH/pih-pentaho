-- Create program dimension

DROP TABLE IF EXISTS dim_program;

create table dim_program (
  program_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

insert into dim_program (name)
    select distinct(program) from omrs_program_enrollment order by program
;

ALTER TABLE dim_program ADD INDEX dim_program_name_idx (name);
