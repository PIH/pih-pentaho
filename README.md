# pih-pentaho
==============

Repository hosting PIH data warehousing scripts built on the Pentaho product suite.  This contains:

* Kettle jobs (*.kjb):  Represent a sequence of transforms that can be executed or run on a schedule to process data
* Kettle transforms (*.ktr):  Represent specific data transformations (Extract, Transform, and Load) that can be exectuted within one more more jobs


Example transforms we will need to support:

* Combine multiple columns into a single value

  Examples:
     - concatenate all non-empty of given_name, middle_name separated by spaces -> first_name
     - concatenate all non-empty of family_name_prefix, family_name, family_name2, family_name_suffix into last_name

* Combine multiple rows into a single value

  Examples:
     - Concatenate all identifiers of a certain type, separated by commas into a single value

* Lookup metadata code/name by primary key id

  Examples:
     - Get the text value for a location given a location_id

* Rename columns from extract -> load

  Examples: For Malawi, address columns should be renamed from:
     - state_province -> "district"
     - county_district -> "traditional_authority"
     - city_village -> "village"
