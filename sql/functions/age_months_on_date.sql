
DROP FUNCTION IF EXISTS age_months_on_date;

CREATE FUNCTION age_months_on_date(birthdate date, agedate date) RETURNS INT DETERMINISTIC

  RETURN if (birthdate is null or agedate is null, null, TIMESTAMPDIFF(MONTH, birthdate, agedate));
