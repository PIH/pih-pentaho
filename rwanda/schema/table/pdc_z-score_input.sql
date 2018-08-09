CREATE TABLE pdc_z_score_input (
	patient_id INT,
    obs_date DATE,
    weight DOUBLE DEFAULT NULL,
    clenhei DOUBLE DEFAULT NULL,
    lh TEXT,
    oedema INT,
    sex VARCHAR(1),
    agedays INT
);