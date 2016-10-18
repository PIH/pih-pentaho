/*
  Extracts basic attributes of a patient that are directly accessible from the patient and person tables
 */
select      n.uuid as uuid,
            n.gender,
            n.birthdate,
            n.birthdate_estimated,
            n.birthtime,
            n.dead,
            n.death_date,
            n.cause_of_death
from        patient p
inner join  person n on p.patient_id = n.person_id
where       p.voided = 0
and         n.voided = 0