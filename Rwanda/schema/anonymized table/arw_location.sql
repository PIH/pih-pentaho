
CREATE TABLE rw_location (
 	location_id INT not null,
    name VARCHAR(255),
	description VARCHAR(1023),
	address1 VARCHAR(255),
	address2 VARCHAR(255),
	address3 VARCHAR(255),
	address4 VARCHAR(255),
	city_village VARCHAR(255),
	state_province VARCHAR(255),
	country VARCHAR(255),
	county_district VARCHAR(255)
  
);

alter table rw_location add index rw_location_id(location_id);
