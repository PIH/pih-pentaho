CREATE TABLE rw_bill (
	patient_id INT,
    amount decimal(20,2),
    amount_3rd_part decimal(20,2),
    amount_insurance decimal(20,2),
    amount_patient decimal(20,2),
    is_paid int,
    created_date datetime default NULL,
    creator varchar(127),
    creator_uuid varchar(127),
    patient_bill_id INT
);

