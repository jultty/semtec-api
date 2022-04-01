FROM eclipse-temurin:11-jdk-alpine AS maven_tool_chain
RUN apk add --no-cache maven
COPY pom.xml /tmp/
COPY src /tmp/src/
RUN mkdir /app
WORKDIR /tmp
RUN mvn -B dependency:go-offline -f /tmp/pom.xml
RUN mvn -B package
RUN mv target/semtec-0.2.0-SNAPSHOT.jar /app/semtec-0.2.0-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/semtec-0.2.0-SNAPSHOT.jar"]
