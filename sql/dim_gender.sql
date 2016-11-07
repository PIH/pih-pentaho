-- Create gender dimension

DROP TABLE IF EXISTS dim_gender;

create table dim_gender (
  gender_id INT AUTO_INCREMENT PRIMARY KEY,
  code char(1),
  name_en varchar(15)
);

insert into dim_gender (code, name_en) values ('M', 'Male');
insert into dim_gender (code, name_en) values ('F', 'Female');

ALTER TABLE dim_gender ADD INDEX dim_gender_code_idx (code);