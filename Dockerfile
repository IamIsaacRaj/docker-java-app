
# Use the official Maven image to build the application
FROM maven:3.6.3-openjdk-17 AS build

# Set the Working directory inside the container
WORKDIR /app

# Copy the pom.xml file and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the project source code
COPY src ./src

# Package the Application
RUN mvn package

# Use the official Java Image to run the application
FROM openjdk:17-jdk-slim

# set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the target directory to the working directory
COPY target/docker-java-app-1.0-SNAPSHOT.jar app.jar

# Command to run the JAR file
CMD ["java", "-jar", "app.jar"]
