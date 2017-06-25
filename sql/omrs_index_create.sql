
-- Create all of the indexes for the omrs tables

alter table omrs_patient add index patient_id_idx (patient_id);

alter table omrs_patient_identifier add index patient_identifier_id_idx (patient_identifier_id);
alter table omrs_patient_identifier add index omrs_patient_identifier_patient_idx (patient_id);
alter table omrs_patient_identifier add index omrs_patient_identifier_location_idx (location);

alter table omrs_relationship add index omrs_relationship_relationship_id_idx (relationship_id);
alter table omrs_relationship add index omrs_relationship_patient_idx (patient_id);

alter table omrs_encounter_provider add index encounter_provider_id_idx (encounter_provider_id);

alter table omrs_encounter add index omrs_encounter_id_idx (encounter_id);
alter table omrs_encounter add index omrs_encounter_patient_idx (patient_id);
alter table omrs_encounter add index omrs_encounter_date_idx (encounter_date);
alter table omrs_encounter add index omrs_encounter_time_idx (encounter_time);
alter table omrs_encounter add index omrs_encounter_type_idx (encounter_type);
alter table omrs_encounter add index omrs_encounter_form_idx (form);
alter table omrs_encounter add index omrs_encounter_location_idx (location);

alter table omrs_visit add index omrs_visit_id_idx (visit_id);
alter table omrs_visit add index omrs_visit_patient_idx (patient_id);
alter table omrs_visit add index omrs_visit_date_started_idx (date_started);
alter table omrs_visit add index omrs_visit_date_stopped_idx (date_stopped);
alter table omrs_visit add index omrs_visit_type_idx (visit_type);
alter table omrs_visit add index omrs_visit_location_idx (location);

alter table omrs_obs add index omrs_obs_id_idx (obs_id);
alter table omrs_obs add index omrs_obs_patient_idx (patient_id);
alter table omrs_obs add index omrs_obs_date_idx (obs_date);
alter table omrs_obs add index omrs_obs_time_idx (obs_time);
alter table omrs_obs add index omrs_obs_concept_idx (concept);
alter table omrs_obs add index omrs_obs_encounter_type_idx (encounter_type);
alter table omrs_obs add index omrs_obs_location_idx (location);

alter table omrs_obs_group add index omrs_bos_group_id_idx (obs_group_id);
alter table omrs_obs_group add index omrs_obs_group_patient_idx (patient_id);
alter table omrs_obs_group add index omrs_obs_group_date_idx (obs_group_date);
alter table omrs_obs_group add index omrs_obs_group_time_idx (obs_group_time);
alter table omrs_obs_group add index omrs_obs_group_concept_idx (concept);
alter table omrs_obs_group add index omrs_obs_group_encounter_type_idx (encounter_type);
alter table omrs_obs_group add index omrs_obs_group_location_idx (location);

alter table omrs_program_enrollment add index omrs_program_enrollment_id_idx (program_enrollment_id);
alter table omrs_program_enrollment add index omrs_program_enrollment_patient_idx (patient_id);

alter table omrs_program_state add index omrs_program_state_id_idx (program_state_id);
alter table omrs_program_state add index omrs_program_state_enrollment_id_idx (program_enrollment_id);
