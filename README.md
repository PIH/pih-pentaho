# pih-pentaho
==============

Repository hosting PIH data warehousing scripts built on the Pentaho product suite.  This contains:

* Kettle jobs (*.kjb):  Represent a sequence of transforms that can be executed or run on a schedule to process data
* Kettle transforms (*.ktr):  Represent specific data transformations (Extract, Transform, and Load) that can be exectuted within one more more jobs

=====================

DEV ENVIRONMENT SETUP (TODO: confirm that these steps are correct next time someone sets up a new enviromnent)

Install kettle (for deploying to a server, look at Pentaho playbook and roles in the deployment project in Bitbucket):

* Download Pentaho Kettle from here: http://community.pentaho.com/projects/data-integration/  (we are currently using version 6.1, for what it's worth)
* Unzip and copy into your preferred executable directory
* Install the dependencies listed in README_LINUX.txt in the top-level Kettle directory (sudo apt-get install libwebkitgtk-1.0.0)
* Download the latest mysql connector jar from here: https://dev.mysql.com/downloads/file/?id=465644
* Extract the mysql connector jar out of the above zip file and copy it into the data-integration/lib
* Run "spoon.sh" to start
* When running a job, set the "PIH_PENTAHO_HOME" parameter point to the top-level directory for your Pentaho project (ie, the top-level directory of this proiect) (this parameter is stored in $HOME/.kettle/kettle.properties)

Link your shared.xml to the shared file used by the project:
* Go to $HOME/.kettle/shared.xml and delete this file if it exists
* Create a new shared.xml that is a symbolic link to to "shared/shared-connections.xml" in this project.

Create a pih-kettle.properties file in the .kettle with the following variables set to your preferred values:

```
pih.country  = haiti

openmrs.db.host = localhost
openmrs.db.port = 3306
openmrs.db.name = openmrs
openmrs.db.user = root
openmrs.db.password = 

warehouse.db.host = localhost
warehouse.db.port = 3306
warehouse.db.name = openmrs_warehouse
warehouse.db.user = root
warehouse.db.password = 
warehouse.db.key_prefix = 10
```


=======================

RUNNING VIA DOCKER


Usage:

* Make sure docker is installed and running on the target machine:
    Use our docker ansible playbook, or:
    https://docs.docker.com/engine/installation/linux/ubuntulinux/
    
* Clone this repo into /home/reporting on the target machine

* Build the image locally on the target machine:
    cd /home/reporting/pih-pentaho/docker
    sudo docker build -t pih:pdi .
    
* Create a custom "pih-kettle.properties" file in "/home/reporting/.kettle" based on pih-kettle-default.properties, but customized for this install

* Create the warehouse database in mysql: "create database <warehouse_db_name> default charset utf-8", where <warehouse_db_name> is set to the warehouse.db.name as specified in pih-kettle.properties
    
* To run the "load-from-opennmrs" job on the target machine using kitchen:
    sudo docker run --net="host" --rm -v /home/reporting:/home/reporting -v /home/reporting/.kettle/pih-kettle.properties:/opt/pentaho/.kettle/pih-kettle.properties pih:pdi /opt/pentaho/data-integration/kitchen.sh -file="/home/reporting/pih-pentaho/jobs/load-from-openmrs-and-star-schema.kjb"

    --net="host" : allows the container to connect to mysql on the host machine via 127.0.0.1
     /home/reporting:/home/reporting: mounts the /home/reporting directory on the host machine to /home/reporting in the container



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

