
DELIMITER $$

DROP FUNCTION IF EXISTS first_state_location;

$$

CREATE FUNCTION first_state_location(patient_uuid CHAR(38), program VARCHAR(100), workflow VARCHAR(100), state VARCHAR(100)) RETURNS VARCHAR(255) DETERMINISTIC
  BEGIN

    DECLARE ret VARCHAR(255) default null;

    select		location into ret
    from		  omrs_program_state
    where		  program = program
    and       workflow = workflow
    and       state = state
    and       patient_uuid = patient_uuid
    order by  start_date
    limit     1;

    return ret;
  END

$$
