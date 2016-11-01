# pih-pentaho
==============

Repository hosting PIH data warehousing scripts built on the Pentaho product suite.  This contains:

* Kettle jobs (*.kjb):  Represent a sequence of transforms that can be executed or run on a schedule to process data
* Kettle transforms (*.ktr):  Represent specific data transformations (Extract, Transform, and Load) that can be exectuted within one more more jobs

=====================

Enviromental variables to set:

PIH_PENTAHO_HOME  -- points to the top-level directory where the pih-pentaho project can be found

=====================

Setup steps (should be puppet or ansiblized at some point):

* Download Pentaho Kettle from here: http://community.pentaho.com/projects/data-integration/  (we are currently using version 6.1, for what it's worth)
* Unzip and copy into your preferred executable directory
* Install the dependencies listed in README_LINUX.txt in the top-level Kettle directory (sudo apt-get install libwebkitgtk-1.0.0)
* Download the latest mysql connector jar from here: https://dev.mysql.com/downloads/file/?id=465644
* Extract the mysql connector jar out of the above zip file and copy it into the data-integration/lib
* Run "spoon.sh" to start
* When running a job, set the "PIH_PENTAHO_HOME" parameter point to the top-level directory for your Pentaho project (ie, the top-level directory of this proiect)

=======================

Running via docker


Usage:

* To build the image locally on the target machine:
    **cd /home/pih-pentaho/docker**
    **sudo docker build -t pih:pdi .**
    
* To run the "load-from-opennmrs" job on the target machine using kitchen:
    **sudo docker run --net="host" --rm -v /home/pih-pentaho:/home/pih-pentaho pih:pdi data-integration/kitchen.sh -file="/home/pih-pentaho/jobs/load-from-openmrs.kjb"**
   
    --net="host" : allows the container to connect to mysql on the host machine via 127.0.0.1
     /home/pih-pentaho:/home/pih-pentaho: mounts the /home/pih-pentaho directory on the host machine to /home/pih-pentaho in the container


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

