
CREATE TABLE rw_order (
  order_id VARCHAR(32) not null,
  fosa_id INT not null,
  order_type_id INT,
  concept VARCHAR(100),
  orderer VARCHAR(100),
  instructions VARCHAR(1023),
  start_date date,
  auto_expire_date date,
  discontinued_date date,
  discontinued_by VARCHAR(255),
  discontinued_reason VARCHAR(1023),
  patient_id VARCHAR(32),
  uuid VARCHAR(255),
  discontinued_reason_non_coded VARCHAR(1023),
  urgency VARCHAR(255),
  date_created date,
  encounter_id VARCHAR(32),
  encounter_type VARCHAR(255),
  location VARCHAR(255)
  
);

alter table rw_order add index rw_order_id(order_id);