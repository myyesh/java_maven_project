# Use an official Maven runtime as a parent image for building the app
FROM maven:3.8-jdk-11-slim AS build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents (your Maven project) into the container at /usr/src/app
COPY . .

# Build the application inside the container
RUN mvn clean package

# Use the official Java runtime for running the app
FROM openjdk:8-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built jar file from the build container
COPY --from=build /usr/src/app/target/gs-maven-0.1.0.jar /app

# Specify the command to run on container start
CMD ["java", "-jar", "gs-maven-0.1.0.jar"]
