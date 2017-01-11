
DELIMITER $$

DROP FUNCTION IF EXISTS single_identifier_at_location;

$$

CREATE FUNCTION single_identifier_at_location(patient_uuid CHAR(38), type VARCHAR(50), location VARCHAR(255)) RETURNS VARCHAR(50) DETERMINISTIC
  BEGIN

    DECLARE ret VARCHAR(50) default null;

    select		 max(i.identifier) into ret
    from		  omrs_patient_identifier i
    where		  i.type = type
    and       i.location = location
    and       i.patient_uuid = patient_uuid;

    return ret;
  END

$$
