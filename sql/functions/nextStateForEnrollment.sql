CREATE FUNCTION nextStateForEnrollment(enrollmentId INT, startingDate DATE)
  RETURNS VARCHAR(100)
DETERMINISTIC
  BEGIN
    DECLARE ret VARCHAR(100);

    IF startingDate IS NOT NULL THEN
      SELECT    s.state into ret
      FROM      omrs_program_state s
      WHERE     s.program_enrollment_id = enrollmentId
      AND       s.start_date >= startingDate
      ORDER BY  s.start_date ASC
      LIMIT 1;
    END IF;

    return ret;
  END
