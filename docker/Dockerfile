FROM java:8-jre

MAINTAINER Mark Goodrich

# Set required environment vars
ENV PDI_RELEASE=6.1 \
    PDI_VERSION=6.1.0.1-196 \
    CARTE_PORT=8181 \
    PENTAHO_JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PENTAHO_HOME=/home/pentaho \
    PIH_PENTAHO_HOME=/home/pih-pentaho \
    MYSQL_CONNECTOR_VERSION=5.1.28

## Create user
RUN mkdir ${PENTAHO_HOME} && \
     mkdir ${PIH_PENTAHO_HOME} && \
     groupadd -r pentaho && \
     useradd -s /bin/bash -d ${PENTAHO_HOME} -r -g pentaho pentaho && \
     chown pentaho:pentaho ${PENTAHO_HOME} && \
     chown pentaho:pentaho ${PIH_PENTAHO_HOME}

 # Add files
 #RUN mkdir $PENTAHO_HOME/docker-entrypoint.d $PENTAHO_HOME/templates $PENTAHO_HOME/scripts

# COPY carte-*.config.xml $PENTAHO_HOME/templates/

# COPY docker-entrypoint.sh $PENTAHO_HOME/scripts/

 # RUN chown -R pentaho:pentaho $PENTAHO_HOME
 # chmod +x $PENTAHO_HOME/scripts/docker-entrypoint.sh && \

 # Switch to the pentaho user
 USER pentaho

 # Download PDI
 RUN /usr/bin/wget \
     --progress=dot:giga \
     http://downloads.sourceforge.net/project/pentaho/Data%20Integration/${PDI_RELEASE}/pdi-ce-${PDI_VERSION}.zip \
     -O /tmp/pdi-ce-${PDI_VERSION}.zip && \
     /usr/bin/unzip -q /tmp/pdi-ce-${PDI_VERSION}.zip -d  $PENTAHO_HOME && \
     rm /tmp/pdi-ce-${PDI_VERSION}.zip

# Download mysql plugin
RUN /usr/bin/wget \
    --progress=dot:giga \
     https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_CONNECTOR_VERSION.zip \
    -O /tmp/mysql-connector-java.zip && \
    /usr/bin/unzip -q /tmp/mysql-connector-java.zip -d /tmp && \
    mv /tmp/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}-bin.jar ${PENTAHO_HOME}/data-integration/lib && \
    rm -r /tmp/mysql-connector-java*

# Set kettle properties
RUN mkdir ${PENTAHO_HOME}/.kettle && \
    echo "PIH_PENTAHO_HOME=${PIH_PENTAHO_HOME}" > ${PENTAHO_HOME}/.kettle/kettle.properties


 # We can only add KETTLE_HOME to the PATH variable now
 # as the path gets eveluated - so it must already exist
 ENV KETTLE_HOME=$PENTAHO_HOME \
     PATH=$KETTLE_HOME:$PATH

 # Expose Carte Server
# EXPOSE ${CARTE_PORT}

 # As we cannot use env variable with the entrypoint and cmd instructions
 # we set the working directory here to a convenient location
 # We set it to KETTLE_HOME so we can start carte easily
 WORKDIR $PIH_PENTAHO_HOME


 #ENTRYPOINT ["../scripts/docker-entrypoint.sh"]

 # Run Carte - these parameters are passed to the entrypoint
# CMD ["carte.sh", "carte.config.xml"]


#/home/pentaho/data-integration/kitchen.sh -file="/home/pih-pentaho/jobs/load-from-openmrs.kjb"  -param:PIH_PENTAHO_COUNTRY=
# docker build -t pih:pdi .
#docker run -it --rm --name pentahoContainer --net="host" -v /home/mgoodrich/pih-pentaho:/home/pih-pentaho pih:pdi
#sudo docker run -it --rm --name pentahoContainer --net="host" -v /home/pih-pentaho:/home/pih-pentaho pih:pdi
#https://docs.docker.com/engine/installation/linux/ubuntulinux/

#sudo docker run --net="host" -v /home/pih-pentaho:/home/pih-pentaho pih:pdi /home/pentaho/data-integration/kitchen.sh -file="/home/pih-pentaho/jobs/load-from-openmrs.kjb"  -param:PIH_PENTAHO_COUNTRY=malawi
