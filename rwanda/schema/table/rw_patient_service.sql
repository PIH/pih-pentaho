CREATE TABLE rw_patient_service (
	patient_id INT,
	UNIT_PRICE DECIMAL(20,2),
    quantity decimal(20,2),
    paid_quantity decimal(20,2),
    created_date date,
    is_paid int,
    service_name varchar(250),
    patient_bill_id INT
);

