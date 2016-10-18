/*
  Extracts all patient identifiers
 */
select      p.uuid as patient_uuid,
            i.identifier_type,
            i.identifier,
            i.location_id
from        person p
left join   patient_identifier i on p.person_id = i.patient_id
where       i.voided = 0

