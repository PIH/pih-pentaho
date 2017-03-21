alter table mw_patient add index mw_patient_id_idx (patient_id);

alter table mw_lab_tests add index mw_lab_tests_patient_idx (patient_id);
alter table mw_lab_tests add index mw_lab_tests_patient_type_idx (patient_id, test_type);

alter table mw_eid_visits add index mw_eid_visit_patient_idx (patient_id);
alter table mw_eid_visits add index mw_eid_visit_patient_location_idx (patient_id, location);

alter table mw_eid_register add index mw_eid_register_patient_idx (patient_id);
alter table mw_eid_register add index mw_eid_register_patient_location_idx (patient_id, location);

alter table mw_eid_trace add index mw_eid_trace_patient_idx (patient_id);
alter table mw_eid_trace add index mw_eid_trace_patient_location_idx (patient_id, location);

alter table mw_art_visits add index mw_art_visit_patient_idx (patient_id);
alter table mw_art_visits add index mw_art_visit_patient_location_idx (patient_id, location);

alter table mw_art_register add index mw_art_register_patient_idx (patient_id);
alter table mw_art_register add index mw_art_register_patient_location_idx (patient_id, location);

alter table mw_art_trace add index mw_art_trace_patient_idx (patient_id);
alter table mw_art_trace add index mw_art_trace_patient_location_idx (patient_id, location);

alter table mw_ncd_diagnoses add index mw_ncd_diagnoses_patient_idx (patient_id);
