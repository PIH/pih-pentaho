alter table mw_patient add index patient_id_idx (patient_id);
alter table mw_eid_visits add index eid_visit_patient_idx (patient_id);
alter table mw_eid_visits add index eid_visit_patient_location_idx (patient_id, location);
alter table mw_hiv_tests add index hiv_test_patient_idx (patient_id);