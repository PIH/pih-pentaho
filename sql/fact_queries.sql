
select    count(distinct(p.patient_id)), a.full_years, p.gender
from      fact_patient_event e, dim_age a, dim_patient p
where     e.age_id = a.age_id
and       e.patient_id = p.patient_id
group by  a.full_years, p.gender;



/*
  HCC Register at a particular location
 */
select  *
from    mw_hiv_register
where   hcc_number is not null
and     (pre_art_start_date is not null or exposed_child_start_date is not null)
and     location = 'Ligowe HC'
;


