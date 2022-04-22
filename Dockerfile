FROM alpine:3.15.3 AS alpine
RUN apk add --no-cache maven openjdk11
COPY pom.xml /tmp/
RUN mvn -B dependency:go-offline -f /tmp/pom.xml
COPY src /tmp/src/
WORKDIR /tmp
RUN mvn -B clean package

FROM alpine
RUN apk add --no-cache openjdk11-jre
RUN mkdir /app
COPY --from=alpine /tmp/target/*.jar /app/semtec-0.2.0-SNAPSHOT.jar
VOLUME /tmp
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/semtec-0.2.0-SNAPSHOT.jar"]
