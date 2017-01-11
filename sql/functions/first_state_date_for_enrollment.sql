
DELIMITER $$

DROP FUNCTION IF EXISTS first_state_date_for_enrollment;

$$

CREATE FUNCTION first_state_date_for_enrollment(enrollment_uuid CHAR(38), workflow VARCHAR(100), state VARCHAR(100)) RETURNS DATE DETERMINISTIC
  BEGIN

    DECLARE ret DATE default null;

    select		min(start_date) into ret
    from		  omrs_program_state
    where		  program_enrollment_uuid = enrollment_uuid
    and       workflow = workflow
    and       state = state;

    return ret;
  END

$$
