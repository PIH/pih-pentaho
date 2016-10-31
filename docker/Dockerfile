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

# Create user
RUN mkdir ${PENTAHO_HOME} && \
     mkdir ${PIH_PENTAHO_HOME} && \
     groupadd -r pentaho && \
     useradd -s /bin/bash -d ${PENTAHO_HOME} -r -g pentaho pentaho && \
     chown pentaho:pentaho ${PENTAHO_HOME} && \
     chown pentaho:pentaho ${PIH_PENTAHO_HOME}

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

ENV KETTLE_HOME=$PENTAHO_HOME \
     PATH=$KETTLE_HOME:$PATH

WORKDIR $PENTAHO_HOME

