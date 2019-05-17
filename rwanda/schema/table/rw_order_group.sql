
CREATE TABLE rw_order_group (
  order_group_id INT not null,
  uuid CHAR(38),
  group_type VARCHAR(255),
  cycle_number INT,
  date_created date,
  order_set_uuid VARCHAR(255),
  order_set_name VARCHAR(255),
  order_set_description VARCHAR(1023),
  indication VARCHAR(255),
  first_start_date date,
  Last_start_date date,
  first_discontinued date,
  last_discontinued date,
  patient_id INT not null,
  initially_planned_end date,
  Order_day_registered CHAR(38)
  
);

alter table rw_order_group add index rw_order_group_order_group_id(order_group_id);
