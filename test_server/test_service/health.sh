#!/bin/bash

API_HOST=${API_HOST:-"http://localhost:9091"}
HEALTH_URL="$API_HOST/health"

# Make request
response=$(curl -s -w "\n%{http_code}" "$HEALTH_URL")
body=$(echo "$response" | sed '$d') # Extract JSON body
status_code=$(echo "$response" | tail -n1) # Extract status code

# Check status code
if [ "$status_code" -ne 200 ]; then
  echo "❌ Server is not running or responding incorrectly (Status: $status_code)"
  exit 1
fi

# Validate JSON response using jq
if ! echo "$body" | jq -e '.ok and .message and .host and .pid and .services' > /dev/null; then
  echo "❌ Response JSON is missing required fields"
  exit 1
fi

# Check if 'ok' field is an integer
if ! echo "$body" | jq -e '.ok | numbers' > /dev/null; then
  echo "❌ 'ok' field is not an integer"
  exit 1
fi

echo "✅ Server is running correctly: $body"
exit 0