
CREATE TABLE arw_order (
  research_order_id BIGINT not null,
  order_type_id INT,
  concept VARCHAR(100),
  orderer VARCHAR(100),
  instructions VARCHAR(1023),
  start_date date,
  auto_expire_date date,
  discontinued_date date,
  discontinued_by VARCHAR(255),
  discontinued_reason VARCHAR(1023),
  research_patient_id BIGINT,
  discontinued_reason_non_coded VARCHAR(1023),
  urgency VARCHAR(255),
  date_created date,
  research_encounter_id BIGINT,
  encounter_type VARCHAR(255),
  location VARCHAR(255),
  research_group_id BIGINT,
  order_index INt,
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

alter table rw_order add index rw_order_id(research_order_id);
