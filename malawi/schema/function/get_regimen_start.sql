/*
  This is a helper function specifically for the Consecutive High Viral Load Report. 
  See: api/src/main/resources/org/openmrs/module/pihmalawi/reporting/datasets/sql/consecutive-high-viral-load.sql

  The function expects the presence of a regimenStartTable and relies on an intenger patientID
  and the offsetNum determines the regimen to retrieve (0 for latest, 1 for second latest, etc).
  Returns the associated regimen start date. 

*/

CREATE FUNCTION get_regimen_start(patientId INT, offsetNum INT)
  RETURNS DATE
DETERMINISTIC
  BEGIN
    DECLARE ret DATE;
    
    SELECT start_date into ret 
    FROM regimenStartTable2 
    WHERE patient_id = patientId 
    ORDER BY start_date DESC 
    LIMIT 1 
    OFFSET offsetNum;

    return ret;
  END