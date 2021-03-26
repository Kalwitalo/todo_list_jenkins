FROM maven:3.6.3-jdk-8 AS MAVEN_BUILD

MAINTAINER Kalwitalo Ibiapina

COPY pom.xml /build/
COPY src /build/src/

WORKDIR /build/
RUN mvn package

FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=MAVEN_BUILD /build/target/*.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]