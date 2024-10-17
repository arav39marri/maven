# Stage 1: Build the application
FROM maven:3.8.1-openjdk-8 AS build

WORKDIR /app

# Copy only the necessary files to build the project
COPY pom.xml .
COPY src ./src

# Run Maven to build the application
RUN mvn clean package

# Stage 2: Run the application
FROM openjdk:8-jre

WORKDIR /app

# Copy the built JAR from the first stage
COPY --from=build /app/target/helloworld-maven-0.0.1-SNAPSHOT-jar-with-dependencies.jar /app/hello-world.jar

# Expose port (if your app runs on a specific port, e.g., 8080)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/hello-world.jar"]
