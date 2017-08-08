-- Ensure a user account exists with the given attributes
-- Note that password & salt will only be set on new users--existing user passwords will not be updated
CREATE PROCEDURE create_user (
  _source_user_id INT,
  _user_uuid      CHAR(38),
  _person_uuid    CHAR(38),
  _username       VARCHAR(255),
  _email          VARCHAR(255),
  _given_name     VARCHAR(255),
  _family_name    VARCHAR(255),
  _password       VARCHAR(255),
  _salt           VARCHAR(255),
  _member_state   VARCHAR(255)
)
BEGIN

  DECLARE _person_id INT;
  DECLARE _user_id INT;
  DECLARE _existing_user_id INT;

  SELECT user_id into _existing_user_id from users where username = _username;

  IF _existing_user_id IS NOT NULL THEN
    SET _username = concat(_username, '-', _source_user_id);
  END IF;

  INSERT INTO person(gender, creator, date_created, uuid) values (null, 1, now(), _person_uuid);
  SELECT person_id into _person_id FROM person WHERE uuid = _person_uuid;
  INSERT INTO person_name(person_id, given_name, family_name, preferred, creator, date_created, uuid) VALUES (_person_id, _given_name, _family_name, 1, 1, now(), uuid());
  INSERT INTO users (person_id, username, system_id, creator, date_created, uuid, password, salt) VALUES (_person_id, _username, _source_user_id, 1, now(), _user_uuid, _password, _salt);
  SELECT user_id into _user_id FROM users WHERE uuid = _user_uuid;
  INSERT INTO user_property (user_id, property, property_value) values (_user_id, 'notificationAddress', _email);

  IF _member_state IN ('deleted','banned') THEN
    UPDATE users set retired = TRUE, retired_by = 1, date_retired = now(), retire_reason = _member_state where uuid = _user_uuid;
  END IF;

END
