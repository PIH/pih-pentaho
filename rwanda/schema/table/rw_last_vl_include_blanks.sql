CREATE TABLE rw_last_vl_include_blanks (
	patient_id INT,
    concept VARCHAR(255),
    obs_id INT,
    end_date DATE,
    last_obs_date DATE,
    encounter_type VARCHAR(255),
    location VARCHAR(255),
    value_coded VARCHAR(255),
    value_date DATE,
    value_numeric DOUBLE DEFAULT NULL,
    value_text TEXT,
    obs_group_id INT
);