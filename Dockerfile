FROM openjdk:8-jdk-alpine
MAINTAINER Kalwitalo Ibiapina
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
