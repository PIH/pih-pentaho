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


