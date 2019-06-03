/*
  This is a helper function specifically for the Consecutive High Viral Load Report. 
  See: api/src/main/resources/org/openmrs/module/pihmalawi/reporting/datasets/sql/consecutive-high-viral-load.sql

  The function expects the presence of a regimenStartTable and relies on an intenger patientID
  and the offsetNum determines the regimen to retrieve (0 for latest, 1 for second latest, etc).
  Returns the associated regimen (varchar). 

*/

CREATE FUNCTION get_regimen(patientId INT, offsetNum INT)
  RETURNS VARCHAR(100)
DETERMINISTIC
  BEGIN
    DECLARE ret VARCHAR(100);
    
    SELECT regimen into ret 
    FROM regimenStartTable 
    WHERE patient_id = patientId 
    ORDER BY start_date DESC 
    LIMIT 1 
    OFFSET offsetNum;

    return ret;
  END