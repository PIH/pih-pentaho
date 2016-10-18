/*
  Extracts at most one attribute of each type for each person, favoring those those most recently created
  This assumes that no more than one non-voided attribute of a given type are intentionally stored for each patient,
  which is generally the assumption that application code makes within OpenMRS
 */
select      p.uuid as person_uuid,
            a.person_attribute_type_id,
            t.format,
            a.value
from        person p
left join   person_attribute a on p.person_id = a.person_id
left join   person_attribute_type t on a.person_attribute_type_id = t.person_attribute_type_id
where       a.person_attribute_id = (
              select    a.person_attribute_id
              from      person_attribute a
              where     a.voided = 0
              and       a.person_id = p.person_id
              AND       a.person_attribute_type_id = t.person_attribute_type_id
              order by  a.date_created desc limit 1
            )
