
DELIMITER $$

DROP FUNCTION IF EXISTS first_encounter_date;

$$

CREATE FUNCTION first_encounter_date(patient_uuid CHAR(38), type VARCHAR(50)) RETURNS DATE DETERMINISTIC
  BEGIN

    DECLARE ret DATE default null;

    select		min(encounter_date) into ret
    from		  omrs_encounter
    where		  encounter_type = type
    and       patient_uuid = patient_uuid;

    return ret;
  END

$$
