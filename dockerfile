# Build Maven Project!
FROM maven:3.6.3-jdk-8-slim AS MAVEN_BUILD
# copy the source tree and the pom.xml to our new container
COPY ./ ./

# package our application code
RUN mvn clean compile vertx:package
# the second stage of our build will use open jdk 8 on alpine
FROM openjdk:8-jre-alpine

# copy only the artifacts we need from the first stage and discard the rest
COPY --from=MAVEN_BUILD /target/*.jar /hello-project.jar

# set the startup command to execute the jar
ENTRYPOINT ["java", "-jar", "/hello-project.jar"]
