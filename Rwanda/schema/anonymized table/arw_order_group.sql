
CREATE TABLE arw_order_group (
  research_order_group_id BIGINT not null,
  group_type VARCHAR(255),
  cycle_number INT,
  date_created date,
  order_set_uuid VARCHAR(255),
  order_set_name VARCHAR(255),
  order_set_description VARCHAR(1023),
  indication VARCHAR(255)
);

alter table rw_order_group add index rw_order_group_order_group_id(research_order_group_id);
