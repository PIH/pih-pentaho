# pih-pentaho
==============

Repository hosting PIH data warehousing scripts built on the Pentaho product suite.  This contains:

* Kettle jobs (*.kjb):  Represent a sequence of transforms that can be executed or run on a schedule to process data
* Kettle transforms (*.ktr):  Represent specific data transformations (Extract, Transform, and Load) that can be exectuted within one more more jobs

=====================

Necessary Kettle variables:

PIH_PENTAHO_HOME  -- points to the top-level directory where the jobs and transforms subfolders should be found
PIH_PENTAHO_COUNTRY  -- [malawi,haiti] -- controls which config file is loaded at config/[country].properties

=====================

Setup steps (should be puppet or ansiblized at some point):

* Download Pentaho Kettle from here: http://community.pentaho.com/projects/data-integration/  (we are currently using version 6.1, for what it's worth)
* Unzip and copy into your preferred executable directory
* Install the dependencies listed in README_LINUX.txt in the top-level Kettle directory (sudo apt-get install libwebkitgtk-1.0.0)
* Download the latest mysql connector jar from here: https://dev.mysql.com/downloads/file/?id=465644
* Extract the mysql connector jar out of the above zip file and copy it into the data-integration/lib
* Run "spoon.sh" to start
* Add a new kettle variable (via Edit->Edit the kettle.properties file), "PIH_PENTAHO_HOME" to point to the top-level directory for your Pentaho project (ie, the top-level directory of this proiect)


=====================

Possible organizational approach (from https://github.com/nagkumar/kettle-franchise):


* Organize jobs by:
  * pre-processing (PRE): (load reference data, disable end-user access, etc)
  * staging (STG):  (setting up of the staging area)
  * operational (ODS):  (load operational data store)
  * data warehouse (DWH):  (load multi-dimensional data warehouse)
  * post-processing (PST):  (re-enable end-user access, run statistics, clean up, etc)

* Organize configuration/jobs by:
  * site
  * environment (dev, test, prod)
  * Load appropriate config files into:
    * $HOME/.kettle/kettle.properties
    * $HOME/.kettle/shared.xml
    * $HOME/.kettle/.spoonrc
  
* Create scripts for setting up environment and launching processes

* Create folders for:
  * database and code dumps (dmp)
  * documentation (doc)
  * log files (log)
  * temporary area (tmp)
  * configuration files (config)
  * pentaho config - jobs and transformation xml (code)
 

==========================

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

