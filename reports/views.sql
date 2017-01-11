
set @location = 'Ligowe HC';
set @endDate = now();

DROP TEMPORARY TABLE IF EXISTS hcc_number;

CREATE TEMPORARY TABLE hcc_number AS (
  select		i.patient_uuid, i.identifier
  from		  omrs_patient_identifier i
  where		  i.patient_identifier_uuid = (
    select    l.patient_identifier_uuid
    from      omrs_patient_identifier l
    where     l.patient_uuid = i.patient_uuid
    and       l.type = 'HCC Number'
    and       l.location = @location
    order by  l.identifier asc
    limit     1
  )
);






/*
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
*/


CREATE OR REPLACE VIEW first_encounter_by_type AS
    select		*
    from		  omrs_encounter e
    where		  e.encounter_uuid = (
      select    l.encounter_uuid
      from      omrs_encounter l
      where     l.patient_uuid = e.patient_uuid
      and       l.encounter_type = e.encounter_type
      order by  l.encounter_date asc
      limit     1
    )
;

CREATE OR REPLACE VIEW single_identifier_at_location AS
  select		*
   from		  omrs_patient_identifier i
   where		  i.patient_identifier_uuid = (
     select    l.patient_identifier_uuid
     from      omrs_patient_identifier l
     where     l.patient_uuid = i.patient_uuid
     and       l.type = i.type
     order by  l.identifier asc
     limit     1
   )
;

CREATE OR REPLACE VIEW all_identifiers AS
  select		i.patient_uuid, i.type, group_concat(distinct i.identifier SEPARATOR ' ') as identifiers
  from		  omrs_patient_identifier i
  group by  i.patient_uuid, i.type
;

CREATE OR REPLACE VIEW first_state_for_patient AS
  select		*
  from		  omrs_program_state s
  where		  s.program_state_uuid = (
    select    l.program_state_uuid
    from      omrs_program_state l
    where     l.patient_uuid = s.patient_uuid
    and       l.program = s.program
    and       l.workflow = s.workflow
    and       l.state = s.state
    order by  l.start_date asc
    limit     1
  )
;

CREATE OR REPLACE VIEW first_state_for_enrollment AS
  select		*
  from		  omrs_program_state s
  where		  s.program_state_uuid = (
    select    l.program_state_uuid
    from      omrs_program_state l
    where     l.program_enrollment_uuid = s.program_enrollment_uuid
    and       l.workflow = s.workflow
    and       l.state = s.state
    order by  l.start_date asc
    limit     1
  )
;

CREATE OR REPLACE VIEW first_pre_art_or_exposed_child_state_for_enrollment AS
  select		*
  from		  omrs_program_state s
  where		  s.program_state_uuid = (
    select    l.program_state_uuid
    from      omrs_program_state l
    where     l.program_enrollment_uuid = s.program_enrollment_uuid
    and       l.workflow = 'Treatment Status'
    and       l.state in ('Pre-ART (Continue)', 'Exposed Child (Continue)')
    order by  l.start_date asc
    limit     1
  )
;

CREATE OR REPLACE VIEW last_pre_art_or_exposed_child_state_for_enrollment AS
  select		*
  from		  omrs_program_state s
  where		  s.program_state_uuid = (
    select    l.program_state_uuid
    from      omrs_program_state l
    where     l.program_enrollment_uuid = s.program_enrollment_uuid
    and       l.workflow = 'Treatment Status'
    and       l.state in ('Pre-ART (Continue)', 'Exposed Child (Continue)')
    order by  l.start_date desc
    limit     1
  )
;

CREATE OR REPLACE VIEW first_state_after_pre_art_or_exposed_child_state_for_enrollment AS
  select		  s.*
  from		    omrs_program_state s
  where		    s.program_state_uuid = (
      select      l.program_state_uuid
      from        omrs_program_state l
      inner join  last_pre_art_or_exposed_child_state_for_enrollment e on e.program_enrollment_uuid = l.program_enrollment_uuid
      where       l.program_enrollment_uuid = s.program_enrollment_uuid
      and         l.workflow = 'Treatment Status'
      and         l.program_state_uuid != e.program_state_uuid
      and         l.start_date >= e.start_date
      order by    l.start_date asc
      limit       1
  )
;

CREATE OR REPLACE VIEW last_state_for_enrollment AS
  select		*
  from		  omrs_program_state s
  where		  s.program_state_uuid = (
    select    l.program_state_uuid
    from      omrs_program_state l
    where     l.program_enrollment_uuid = s.program_enrollment_uuid
    and       l.workflow = s.workflow
    and       l.state = s.state
    order by  l.start_date desc
    limit     1
  )
;