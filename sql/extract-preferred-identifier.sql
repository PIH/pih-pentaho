/*
  Extracts at most one identifier for each patient, favoring preferred, and then date created
 */
select      p.uuid as patient_uuid,
            i.identifier
from        person p
left join   patient_identifier i on p.person_id = i.patient_id
where       i.patient_identifier_id = (
              select    i.patient_identifier_id
              from      patient_identifier i
              where     i.voided = 0
              and       i.patient_id = p.person_id
              order by  i.preferred desc, i.date_created desc limit 1
            )
