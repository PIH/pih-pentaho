drop table if exists hivmigration_users;

create table hivmigration_users (
	source_user_id int,
	user_uuid char(38),
  person_uuid char(38),
	username varchar(50),
	email varchar(100),
	first_name varchar(100),
	last_name varchar(100),
	password varchar(255),
	salt varchar(255),
	member_state varchar(100)
);