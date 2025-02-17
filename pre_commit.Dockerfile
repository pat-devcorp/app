# Use the official Flutter image
FROM ghcr.io/cirruslabs/flutter:latest

# Ensure we have the correct Dart version
RUN flutter --version && \
    dart --version && \
    flutter doctor

# Set the working directory
WORKDIR /app

# Install OWASP Dependency Check
RUN apt-get update && apt-get install -y wget unzip \
    && wget https://github.com/jeremylong/DependencyCheck/releases/download/v8.4.1/dependency-check-8.4.1-release.zip \
    && unzip dependency-check-8.4.1-release.zip -d /opt/dependency-check \
    && rm dependency-check-8.4.1-release.zip

# Set environment variables for OWASP Dependency Check
ENV PATH="/opt/dependency-check/bin:$PATH"

# Set the working directory inside the container
WORKDIR /app

# Copy only pubspec files first to leverage Docker caching
COPY pubspec.yaml pubspec.lock ./

# Install dependencies
RUN flutter pub get || echo "⚠️ flutter pub get failed"

# Copy the rest of the application
COPY . .

# Install OWASP Dependency Check
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://github.com/jeremylong/DependencyCheck/releases/download/v9.0.0/dependency-check-9.0.0-release.zip && \
    unzip -o dependency-check-9.0.0-release.zip -d /opt/dependency-check && \
    rm dependency-check-9.0.0-release.zip

# Set the entrypoint to execute the script
ENTRYPOINT ["./pre_commit.sh"]
