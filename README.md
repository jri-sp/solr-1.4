![alt text](https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRQNj5ol8l1KHOHE34XmyZuEncuSMPxoCTnGoKb18urfeYuawL7Dg)

Solr image build with tomcat:6.0 and java:6-jre Docker images 

## Pull Docker image
```
docker pull sebstinkeste/solr-1.4:jre6
```

## build and run the Docker image
```
docker build -t solr .
docker run -it --rm --name my-solr solr
```
you can test it by visiting http://container_IP:8983/solr in a browser

## Tomcat environment variables

```
CATALINA_HOME: /usr/local/tomcat
```
## Solr environment variables

```
SOLR_USER: solr
SOLR_UID: 8983
SOLR_VERSION:  apache-solr-1.4.1
```
