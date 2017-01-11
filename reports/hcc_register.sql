
set @location = 'Ligowe HC';

select
  p.source_internal_id as pid,
  hcc_number.identifier as hcc_number,
  hcc_numbers.identifiers as all_hcc_numbers,
  arv_numbers.identifiers as all_arv_numbers,
  first_pre_art_enc.encounter_date as pre_art_initial_visit_date,
  first_pre_art_enc.location as pre_art_initial_visit_location,
  first_pre_art_state.start_date as pre_art_state_date,
  first_pre_art_state.location as pre_art_state_location,
  first_exposed_enc.encounter_date as exposed_initial_visit_date,
  first_exposed_enc.location as exposed_initial_visit_location,
  first_exposed_state.start_date as exposed_state_date,
  first_exposed_state.location as exposed_state_location,
  p.first_name,
  p.last_name,
  p.birthdate,
  age_years_on_date(p.birthdate, now()) as age_years,
  age_months_on_date(p.birthdate, now()) as age_months,
  p.gender as gender,
  p.city_village as village,
  p.county_district as traditional_authority,
  p.state_province as district,
  hcc_outcome_state.state as outcome_in_hcc,
  hcc_outcome_state.start_date as outcome_in_hcc_change_date,
  current_status.state as last_outcome_in_db,
  current_status.start_date as last_outcome_change_date,
  current_status.location as last_outcome_location
from
  omrs_program_enrollment e
  inner join omrs_patient p on p.patient_uuid = e.patient_uuid
  inner join single_identifier_at_location hcc_number on p.patient_uuid = hcc_number.patient_uuid and hcc_number.type = 'HCC Number'
  inner join first_pre_art_or_exposed_child_state_for_enrollment hcc_initial_state on e.program_enrollment_uuid = hcc_initial_state.program_enrollment_uuid
  left join all_identifiers hcc_numbers on p.patient_uuid = hcc_numbers.patient_uuid and hcc_numbers.type = 'HCC Number'
  left join all_identifiers arv_numbers on p.patient_uuid = arv_numbers.patient_uuid and arv_numbers.type = 'ARV Number'
  left join first_encounter_by_type first_pre_art_enc on p.patient_uuid = first_pre_art_enc.patient_uuid and first_pre_art_enc.encounter_type = 'PART_INITIAL'
  left join first_encounter_by_type first_exposed_enc on p.patient_uuid = first_exposed_enc.patient_uuid and first_exposed_enc.encounter_type = 'EXPOSED_CHILD_INITIAL'
  left join first_state_for_patient first_pre_art_state on p.patient_uuid = first_pre_art_state.patient_uuid and first_pre_art_state.program = 'HIV Program' and first_pre_art_state.workflow = 'Treatment Status' and first_pre_art_state.state = 'Pre-ART (Continue)'
  left join first_state_for_patient first_exposed_state on p.patient_uuid = first_exposed_state.patient_uuid and first_exposed_state.program = 'HIV Program' and first_exposed_state.workflow = 'Treatment Status' and first_exposed_state.state = 'Exposed Child (Continue)'
  left join first_state_after_pre_art_or_exposed_child_state_for_enrollment hcc_outcome_state on e.program_enrollment_uuid = hcc_outcome_state.program_enrollment_uuid
  left join last_state_for_enrollment current_status on e.program_enrollment_uuid = current_status.program_enrollment_uuid and current_status.workflow = 'Treatment Status'
where
  e.location = @location
order by
  hcc_number
;

