
pih-pentaho pih:pdi
===================

Builds a docker container with Pentaho Data Integration component

Usage:

* To build the image locally on the target machine:
    **cd /home/pih-pentaho/docker**
    **sudo docker build -t pih:pdi .**
    
* To run the "load-from-opennmrs" job on the target machine using kitchen:
    **sudo docker run --net="host" --rm -v /home/pih-pentaho:/home/pih-pentaho pih:pdi data-integration/kitchen.sh -file="/home/pih-pentaho/jobs/load-from-openmrs.kjb"**
   
    --net="host" : allows the container to connect to mysql on the host machine via 127.0.0.1
     /home/pih-pentaho:/home/pih-pentaho: mounts the /home/pih-pentaho directory on the host machine to /home/pih-pentaho in the container
      
    
    