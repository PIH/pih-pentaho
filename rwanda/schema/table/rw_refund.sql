CREATE TABLE rw_refund (
	bill_payment_id int,
    refunded_by varchar(127),
    amount_refunded decimal(20,2) DEFAULT NULL,
    refunded_by_person_uuid varchar(127)
);

