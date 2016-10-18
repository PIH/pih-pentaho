/*
  Extracts at most one address for each person, favoring those marked as preferred, followed by those most recently created
  TODO: Consider whether start_date and end_date should factor in
 */
select      p.uuid as person_uuid,
            a.country,
            a.postal_code,
            a.state_province,
            a.county_district,
            a.city_village,
            a.address1,
            a.address2,
            a.address3,
            a.address4,
            a.address5,
            a.address6,
            a.latitude,
            a.longitude
from        person p
left join   person_address a on p.person_id = a.person_id
where       a.person_address_id = (
              select        a.person_address_id
              from          person_address a
              where         a.voided = 0
              and           a.person_id = p.person_id
              order by      a.preferred desc, a.date_created desc limit 1
            )
