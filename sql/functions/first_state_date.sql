
DELIMITER $$

DROP FUNCTION IF EXISTS first_state_date;

$$

CREATE FUNCTION first_state_date(patient_uuid CHAR(38), program VARCHAR(100), workflow VARCHAR(100), state VARCHAR(100)) RETURNS DATE DETERMINISTIC
  BEGIN

    DECLARE ret DATE default null;

    select		min(start_date) into ret
    from		  omrs_program_state
    where		  program = program
    and       workflow = workflow
    and       state = state
    and       patient_uuid = patient_uuid;

    return ret;
  END

$$
