-- Create event dimension

DROP TABLE IF EXISTS dim_event;

create table dim_event (
  event_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50)
);

insert into dim_event (name) VALUES
  ('Program Enrollment'),
  ('Program Completion'),
  ('Encounter')
;

ALTER TABLE dim_event ADD INDEX dim_event_name_idx (name);
