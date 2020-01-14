CREATE TABLE rw_insurance_policy (
	patient_id INT,
    owner varchar(127),
    coverage_start_date date,
    expiration_date date,
    retire_date date,
    retire_reason varchar(250),
    third_part_rate decimal(20,2),
    insurance_company varchar(127),
    owner_uuid varchar(45)
);

