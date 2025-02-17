#!/bin/bash

# Define the APP_PORT
APP_PORT="${APP_PORT:-9090}"

# Check if the APP_PORT is in use and release it if necessary.
echo "Checking if APP_PORT $APP_PORT is in use..."
if [ "$(lsof -t -i :$APP_PORT)" ]; then
  echo "APP_PORT $APP_PORT is in use. Stopping the process on that APP_PORT..."
  fuser -k -n tcp $APP_PORT
fi

# Switch to the web construction directory
cd /app/build/web/

# Start the web server on the specified APP_PORT
echo "Starting the server on APP_PORT $APP_PORT..."
python3 -m http.server $APP_PORT