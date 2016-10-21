* If we need to add in more person attribute data, we can follow what was done for phone_number.  As of now, here are other possible values:

select count(*), t.name
from person_attribute a, person_attribute_type t
where a.person_attribute_type_id = t.person_attribute_type_id
and a.voided = 0
group by t.name
order by count(*) desc;

Neno:

4763		Occupation
9			Mother's Maiden Name
7			Health District
3			Birthplace
3			Citizenship
2			Civil Status
2			Race

Mirebalais:

174			Unknown patient
3			Test Patient

Rwink:

13663		Father's name
3011		Citizenship
3002		Health District
1282		Civil Status
789			Birthplace
257			Race
4			Boarding School

Lesotho:

2715		Health District
2580		Citizenship
2516		Race
2509		Birthplace
1802		Treatment Supporter
1757		Civil Status


=====

A query to generically retrieve attributes:

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