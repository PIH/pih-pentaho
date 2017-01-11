
DELIMITER $$

DROP FUNCTION IF EXISTS all_identifiers;

$$

CREATE FUNCTION all_identifiers(patient_uuid CHAR(38), type VARCHAR(50)) RETURNS VARCHAR(50) DETERMINISTIC
  BEGIN

    DECLARE ret VARCHAR(50) default null;

    select		group_concat(distinct identifier SEPARATOR ' ') into ret
    from		  omrs_patient_identifier i
    where		  i.type = type
    and       i.patient_uuid = patient_uuid;

    return ret;
  END

$$
