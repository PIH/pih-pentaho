
DROP FUNCTION IF EXISTS age_years_on_date;

CREATE FUNCTION age_years_on_date(birthdate date, agedate date) RETURNS INT DETERMINISTIC

  RETURN if (birthdate is null or agedate is null, null, TIMESTAMPDIFF(YEAR, birthdate, agedate));
