FROM openjdk:8
MAINTAINER Caspar
LABEL app="admin-server" version="0.0.1" by="caspar"
COPY ./build/libs/admin-server-0.0.1-SNAPSHOT.jar admin-server.jar
CMD java -jar admin-server.jar --spring.profiles.active=${env}
