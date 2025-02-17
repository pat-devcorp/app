#!/bin/bash

API_HOST=${API_HOST:-"http://localhost:9091"}
ENDPOINT="$API_HOST/client"

# Make request
response=$(curl -s -w "\n%{http_code}" "$ENDPOINT")
body=$(echo "$response" | sed '$d') # Extract JSON body
status_code=$(echo "$response" | tail -n1) # Extract status code

# Check status code
if [ "$status_code" -ne 200 ]; then
  echo "❌ Server is not running or responding incorrectly (Status: $status_code)"
  exit 1
fi

# Validate JSON is an array
if ! echo "$body" | jq -e 'if type == "array" then . else empty end' > /dev/null; then
  echo "❌ Response is not a list"
  exit 1
fi

# Validate each object in the array has required fields
if ! echo "$body" | jq -e 'all(.[]; has("id") and has("name") and has("email"))' > /dev/null; then
  echo "❌ One or more objects are missing required fields (id, name, email)"
  exit 1
fi

# Validate 'id' is an integer and 'name' & 'email' are strings
if ! echo "$body" | jq -e 'all(.[]; (.id | type) == "number" and (.name | type) == "string" and (.email | type) == "string")' > /dev/null; then
  echo "❌ 'id' must be an integer, 'name' and 'email' must be strings"
  exit 1
fi

echo "✅ All checks passed for $ENDPOINT"
exit 0
