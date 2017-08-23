# pih-pentaho
==============

Repository hosting PIH data warehousing scripts built on the Pentaho product suite.  This contains:

* Kettle jobs (*.kjb):  Represent a sequence of transforms that can be executed or run on a schedule to process data
* Kettle transforms (*.ktr):  Represent specific data transformations (Extract, Transform, and Load) that can be exectuted within one more more jobs

=====================

DEV ENVIRONMENT SETUP

For development, it is most helpful to utilize Pentaho Spoon, which is a graphical designer and editor for creating, editing, and viewing
Pentaho jobs and transforms.

* Download Pentaho Kettle from here: http://community.pentaho.com/projects/data-integration/  (we are currently using version 6.1)
* Unzip and copy into your preferred executable directory (eg. /opt/pentaho/data-integration)
* Follow any additional setup instructions here:  http://community.pentaho.com/projects/data-integration/
* Download the latest mysql connector jar from here: https://dev.mysql.com/downloads/file/?id=465644
* Extract the mysql connector jar out of the above zip file and copy it into the data-integration/lib folder
* Create a new mysql database for the warehouse ( eg. _create database openmrs_warehouse default charset utf8;_ )
* Edit or create ~/.kettle/kettle.properties, and add the following: PIH_PENTAHO_HOME=/local/directory/of/pih-pentaho
* Create file at ~/.kettle/pih-kettle.properties with the following variables set to your preferred values:

```
pih.country  = haiti

openmrs.db.host = localhost
openmrs.db.port = 3306
openmrs.db.name = openmrs
openmrs.db.user = root
openmrs.db.password = rootpw

warehouse.db.host = localhost
warehouse.db.port = 3306
warehouse.db.name = openmrs_warehouse
warehouse.db.user = root
warehouse.db.password = rootpw
warehouse.db.key_prefix = 10
```

* Run "spoon.sh" to start

Link your shared.xml to the shared file used by the project:
* Go to $HOME/.kettle/shared.xml and delete this file if it exists
* Create a new shared.xml that is a symbolic link to to "shared/shared-connections.xml" in this project.

* Test it out by trying to run a job in the pih-pentaho/jobs folder (eg. load-from-openmrs.kjb)

=======================

RUNNING VIA PETL

* See https://github.com/PIH/petl

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
