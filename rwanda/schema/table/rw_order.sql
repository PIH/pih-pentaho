
CREATE TABLE rw_order (
  order_id INT not null,
  order_type_id INT,
  concept VARCHAR(100),
  orderer VARCHAR(100),
  instructions VARCHAR(1023),
  start_date date,
  auto_expire_date date,
  discontinued_date date,
  discontinued_by VARCHAR(255),
  discontinued_reason VARCHAR(1023),
  patient_id INT,
  uuid VARCHAR(255),
  discontinued_reason_non_coded VARCHAR(1023),
  urgency VARCHAR(255),
  date_created date,
  encounter_id INT,
  encounter_type VARCHAR(255),
  location VARCHAR(255),
  group_id INT,
  order_index INT,
  indication VARCHAR(255),
  route VARCHAR(255),
  administration_instructions VARCHAR(1023),
  dose DECIMAL,
  equivalent_daily_dose DECIMAL,
  units VARCHAR(255),
  frequency VARCHAR(255),
  prn INT,
  complex VARCHAR(255),
  quantity DECIMAL
);

alter table rw_order add index rw_order_id(order_id);

CREATE TABLE rw_order_group (
  order_group_id varchar(32) not null,
  uuid VARCHAR(255),
  group_type VARCHAR(255),
  cycle_number INT,
  date_created date,
  order_set_uuid VARCHAR(255),
  order_set_name VARCHAR(255),
  order_set_description VARCHAR(1023),
  indication VARCHAR(255)
);

alter table rw_order_group add index rw_order_group_order_group_id(order_group_id);
