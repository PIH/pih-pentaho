

alter table program_enrollment add index program_enrollment_id_idx (program_enrollment_id);
alter table mh_encounter add index encounter_id_idx (encounter_id);
alter table program_statistics add index concept_id_idx (concept_id);
alter table rx_prescriptions add index encounter_id_idx (encounter_id);