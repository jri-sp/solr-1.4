FROM tomcat:6
MAINTAINER Sébastien Stinkeste

RUN apt-get update && apt-get install -y wget
RUN mkdir -p /usr/java && \
    ln -s /usr/lib/jvm/java-6-openjdk-amd64 /usr/java/default && \
    rm -r /var/lib/apt/lists/*

ENV SOLR_USER solr
ENV SOLR_UID 8983
ENV SOLR_FILE  apache-solr-1.4.1
ENV CATALINA_HOME /usr/local/tomcat

RUN groupadd -r ${SOLR_USER} && \
    useradd -r -u ${SOLR_UID} -g ${SOLR_USER} ${SOLR_USER}

WORKDIR /usr/local
RUN wget https://archive.apache.org/dist/lucene/solr/1.4.1/${SOLR_FILE}.tgz && \
    tar -xvf ${SOLR_FILE}.tgz && \
    rm -rf ${SOLR_FILE}.tgz && \
    cp ${SOLR_FILE}/dist/${SOLR_FILE}.war ${CATALINA_HOME}/webapps/solr.war && \
    mkdir -p /tomcat/solr && \
    cp -R ${SOLR_FILE}/example/  ${CATALINA_HOME}/solr && \
    chown -R ${SOLR_USER}:${SOLR_USER} /usr/local 

RUN apt-get remove -y wget && apt-get clean all

COPY server.xml ${CATALINA_HOME}/conf/server.xml
EXPOSE 8983
WORKDIR ${CATALINA_HOME}/solr
USER ${SOLR_USER}
CMD ["java","-jar","start.jar"]




