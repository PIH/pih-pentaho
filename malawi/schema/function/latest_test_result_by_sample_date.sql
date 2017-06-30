/*
  Extract the lab_test_id that identifies the most recent test result of the given type for the given patient
*/
CREATE FUNCTION latest_test_result_by_sample_date(patientId INT, testType VARCHAR(100), fromDate DATE, toDate DATE, offsetNum INT)
  RETURNS INT
DETERMINISTIC
  BEGIN
    DECLARE ret INT;

    SELECT    t.lab_test_id into ret
    FROM      mw_lab_tests t
    WHERE     t.patient_id = patientId
    AND       t.test_type = testType
    AND       (fromDate is null or t.date_collected >= fromDate)
    AND       (toDate is null or t.date_collected <= toDate)
    ORDER BY  t.date_collected desc
    LIMIT     1
    OFFSET    offsetNum;

    return ret;
  END