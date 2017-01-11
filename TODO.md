# TODO Items
==============

* Add Program Workflow + State to the star schema
  * Consider whether this should just go into coded_obs
  * Consider another fact table for longitudinal data, which contains start date and end date, containing visits, enrollments, states,
    and which could potentially have problems and orders added to it.

* Add in creator and date_created where useful, particularly on omrs_encounter and potentially as a dimension

* Determine how to handle obs groups in general, or identify specific use cases to support up-front, like diagnosis

* Consider whether to include anything from value_text in omrs_obs in the star schema

* Exclude test patients from the import patient query


=====================

Dimensions:

* omrs_patient (current omrs_patient table minus death date + reason information, which can be an event)
  - Gender, Birthdate are possible spoke dimensions

* omrs_encounter (encounter_id, encounter_uuid, patient_id, encounter_date, encounter_time)
  - Patient, Encounter Type, Location, Provider, Provider Role possible spoke dimensions

* omrs_obs_group (tbd)
  - Grouping Concept possible spoke dimension

* omrs_program_enrollment ()
  - Program, Location
  
* omrs_program_stage
  - Program, Workflow, State
  
* omrs_relationship

** Location (+ Tags + Attributes)
** Provider
** Encounter Type (+ Program Association)
** Provider Role
** Relationship Type
** Concept (Obs Question)

Facts:

* one "Patient Created" = "True" fact for each patient
  - dimensions:  patient
  
* one "<Identifier Type> Assigned" = identifier for each identifier
  - dimensions:  patient, location
  
* one "Encounter Recorded" = "true" for each encounter
  - dimensions:  patient, location, ...
  
* one "Encounter with Provider" = "true" for each omrs_encounter_provider
  - dimensions:  encounter, provider, role

* one "Obs Recorded / Question Concept" for each obs (coded, date, numeric, text, comments fact columns)
  - subdimensions:  question?, location, encounter, patient
  
* one "Program Enrollment" = "true" for each program enrollment
* one "Program Outcome" = outcome +/- not_recorded for each program enrollment
  - subdimensions:  program, location, 
  
  

eventType					eventSubtype
-----------------------------------------------------------------------------------------------
patient_created				not_applicable      question:  not_applicable,   value_numeric:  null
identifier_assigned			<identifier_type>   question:  <identifier_type>, value_text:  identifier
encounter_recorded			<encounter_type>	question:  Encounter Type,  value_coded:  <encounter_type>
encounter_with_provider		<provider_role>     question:  Provider
obs_recorded				<question_concept>
program_enrollment_started	<program>
program_enrollment_ended	<program>
program_stage_started		<program> - <workflow>
program_stage_ended 		<program> - <workflow>
relationship_started		<relationship_type>
relationship_ended			<relationship_type>


fact_table:
patient_id
encounter_id
obs_group_id
program_enrollment_id
program_stage_id
event_type_id
event_subtype, value_coded, value_numeric, value_date, value_text