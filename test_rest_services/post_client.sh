#!/bin/bash

API_HOST=${API_HOST:-"http://localhost:9091"}
ENDPOINT="$API_HOST/client"

# Function to send a POST request and validate response
send_request() {
  local payload=$1
  local expected_status=$2
  local error_message=$3

  response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$ENDPOINT" \
    -H "Content-Type: application/json" \
    -d "$payload")

  if [ "$response" -ne "$expected_status" ]; then
    echo "❌ $error_message (Expected: $expected_status, Got: $response)"
    exit 1
  else
    echo "✅ Test passed: $error_message"
  fi
}

# ✅ Test Case 1: Valid Client (Should return 201)
valid_payload='{"name": "Braulio", "email": "braulio@gmail.com"}'
send_request "$valid_payload" 201 "Valid client created successfully"

# ❌ Test Case 2: Name is missing (Should return 500)
missing_name_payload='{"email": "test@gmail.com"}'
send_request "$missing_name_payload" 500 "Error when name is missing"

# ❌ Test Case 3: Name has numbers or more than 50 characters (Should return 500)
invalid_name_payload='{"name": "Braulio12345678901234567890123456789012345678901234567890", "email": "test@gmail.com"}'
send_request "$invalid_name_payload" 500 "Error when name has numbers or exceeds 50 characters"

echo "✅ All test cases passed!"
exit 0
