/*
  Extracts at most one name for each person, favoring those marked as preferred, followed by those most recently created
 */
select      p.uuid as person_uuid,
            n.prefix,
            n.given_name,
            n.middle_name,
            n.family_name_prefix,
            n.family_name,
            n.family_name2,
            n.family_name_suffix,
            n.degree
from        person p
left join   person_name n on p.person_id = n.person_id
where       n.person_name_id = (
              select    n.person_name_id
              from      person_name n
              where     n.voided = 0
              and       n.person_id = p.person_id
              order by  n.preferred desc, n.date_created desc limit 1
            )
