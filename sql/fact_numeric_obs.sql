-- Load Numeric Obs into the Fact table
--          patient_id, age_id, date_id, time_id, location_id, program_id, encounter_type_id, metric_id, value
SELECT      p.patient_id, null, d.date_id, t.time_id, l.location_id, null, e.encounter_type_id, m.metric_id, o.value_numeric
FROM        omrs_obs o
INNER JOIN  dim_patient p on o.patient_uuid = p.uuid
INNER JOIN  dim_metric m on m.name = o.concept
LEFT JOIN   dim_date d on d.full_date = o.obs_date
LEFT JOIN   dim_time t on t.full_time = o.obs_time
LEFT JOIN   dim_location l on l.name = o.location
LEFT JOIN   dim_encounter_type e on e.name = o.encounter_type
WHERE       o.value_numeric is not NULL

-- LEFT JOIN   dim_age a on a.age_date = o.obs_date and a.birthdate = p.birthdate