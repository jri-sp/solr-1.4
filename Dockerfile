FROM java:6-jre
FROM tomcat:6
MAINTAINER Sébastien Stinkeste

RUN apt-get update && apt-get install -y wget 
RUN mkdir -p /usr/java && \
    ln -s /usr/lib/jvm/java-6-openjdk-amd64 /usr/java/default

ENV SOLR_USER solr
ENV SOLR_UID 8983
ENV CATALINA_HOME /usr/local/tomcat
ENV SOLR_VERSION  apache-solr-1.4.1

RUN groupadd -r ${SOLR_USER} && \
    useradd -r -u ${SOLR_UID} -g ${SOLR_USER} ${SOLR_USER}

WORKDIR /usr/local
RUN wget https://archive.apache.org/dist/lucene/solr/1.4.1/${SOLR_VERSION}.tgz
RUN tar -xvf ${SOLR_VERSION}.tgz && \
    cp ${SOLR_VERSION}/dist/${SOLR_VERSION}.war ${CATALINA_HOME}/webapps/solr.war && \
    mkdir -p /tomcat/solr && \
    cp -R ${SOLR_VERSION}/example/  ${CATALINA_HOME}/solr && \
    chown -R ${SOLR_USER}:${SOLR_USER} /usr/local

COPY server.xml ${CATALINA_HOME}/conf/serverweb.xml
EXPOSE 8080
WORKDIR ${CATALINA_HOME}/solr
USER ${SOLR_USER}
CMD ["java","-jar","start.jar"]




