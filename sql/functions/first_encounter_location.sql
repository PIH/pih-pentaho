
DELIMITER $$

DROP FUNCTION IF EXISTS first_encounter_location;

$$

CREATE FUNCTION first_encounter_location(patient_uuid CHAR(38), type VARCHAR(50)) RETURNS VARCHAR(255) DETERMINISTIC
  BEGIN

    DECLARE ret VARCHAR(255) default null;

    select		location into ret
    from		  omrs_encounter
    where		  encounter_type = type
    and       patient_uuid = patient_uuid
    order by  encounter_date asc
    limit 1;

    return ret;
  END

$$
