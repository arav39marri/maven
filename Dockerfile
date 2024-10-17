# Stage 1: Build the application
FROM maven:3.8.1-jdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Create the final image
FROM openjdk:11-jre
WORKDIR /app
COPY --from=build /app/target/hello-world-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar /app/hello-world.jar

# Run the application
CMD ["java", "-jar", "hello-world.jar"]
