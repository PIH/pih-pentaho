CREATE TABLE rw_payment (
	bill_payment_id int,
    `amount_paid` decimal(20,2) NOT NULL,
	`date_received` datetime DEFAULT NULL,
    `collector` varchar(127),
    collector_uuid varchar(127),
    `is_cash` int,
    `is_deposit` int,
    patient_id int,
    patient_bill_id int
);

