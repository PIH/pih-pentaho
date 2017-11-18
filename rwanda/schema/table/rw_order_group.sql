
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
