
CREATE TABLE rw_order (
  order_type_id INT,
  concept VARCHAR(100),
  instructions VARCHAR(1023),
  start_date date,
  auto_expire_date date,
  discontinued_date date,
  discontinued_reason VARCHAR(1023),
  discontinued_reason_non_coded VARCHAR(1023),
  urgency VARCHAR(255),
  date_created date,
  encounter_type VARCHAR(255),
  location VARCHAR(255),
  group_id INT,
  order_index INT,
  indication VARCHAR(255),
  route VARCHAR(255),
  administration_instructions VARCHAR(1023),
  dose float DEFAULT NULL,
  equivalent_daily_dose DECIMAL(12,2),
  units VARCHAR(255),
  frequency VARCHAR(255),
  prn INT,
  complex VARCHAR(255),
  quantity DECIMAL,
  order_set VARCHAR(255),
  age_years_at_start_date Int,
  age_months_at_start_date Int,
  drug VARCHAR(255)
  
);



CREATE TABLE rw_order_group (
  order_group_id INT not null,
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
  initially_planned_end date,
  Order_day_registered CHAR(38)
  
);

