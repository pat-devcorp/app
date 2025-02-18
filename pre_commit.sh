#!/bin/bash

# Log a message function
log_message() {
  echo "$1"
}

# Run Flutter pub get
log_message "Running Flutter pub get..."
flutter pub get || { log_message "Flutter pub get failed"; exit 1; }

# Run Dart fix
log_message "Running Dart fix..."
dart fix --apply || { log_message "Dart fix failed"; exit 1; }

# Run Dart format
log_message "Running Dart format..."
dart format . || { log_message "Dart format failed"; exit 1; }

# Run Flutter analyze
log_message "Running Flutter analyze..."
flutter analyze || { log_message "Flutter analyze failed"; exit 1; }

# Run Dart analyze
log_message "Running Dart analyze..."
dart analyze || { log_message "Dart analyze failed"; exit 1; }

# Run Flutter tests
log_message "Running Flutter tests..."
flutter test || { log_message "Flutter tests failed"; exit 1; }

# Run OWASP Dependency Check
log_message "Running OWASP Dependency Check..."
dependency-check.sh --project FlutterApp --scan /app || { log_message "OWASP Dependency Check failed"; exit 1; }
