# Use the official Ubuntu 22.04 LTS base image
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Download and install Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.5-bin.zip \
    && unzip gradle-7.5-bin.zip -d /opt \
    && rm gradle-7.5-bin.zip
ENV GRADLE_HOME /opt/gradle-7.5
ENV PATH $GRADLE_HOME/bin:$PATH

# Setup a new project directory
WORKDIR /app

# Copy the Gradle configuration file
COPY build.gradle /app/

# Copy the Kotlin source code
COPY src /app/src

# Compile the application
RUN gradle build

# Command to run the application
CMD ["gradle", "run"]
