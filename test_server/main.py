from flask import Flask, request, jsonify
from flask_cors import CORS
import multiprocessing
import os
import json

import logging

app = Flask(__name__)
CORS(app)

# In-memory user database (for demonstration purposes only!)
# In a real application, you would use a proper database.
users = {
    "test@example.com": "password123"  # Example user
}

def all_required_services_are_running():
    return True

@app.route('/health')
def health_check():
    if all_required_services_are_running():
        health_data = {
            "ok": 1,
            "message": "OK!",
            "host": "192.168.0.1:8080",
            "pid": 1234,
            "services": {
                "postgres": 1,
                "rabbitmq": 0,
            }
        }

        return jsonify(health_data), 200

    else:
        error_data = {
            "ok": 0,
            "message": "Service Unavailable"
        }

        return jsonify(error_data), 500

@app.route('/login', methods=['POST'])
def login():
    try:
        app.logger.warning("ENTER")
        app.logger.warning("Content-Type:", request.headers.get('Content-Type'))
        data = request.get_json()  # Get JSON data from the request
        app.logger.warning("Received data:", data)  # This is the key change

        if not data:
            return jsonify({"message": "No data provided"}), 400

        email = data.get('email')
        password = data.get('password')

        if not email or not password:
            return jsonify({"message": "Email and password are required"}), 400

        if email in users and users[email] == password:
            return jsonify({"message": "Login successful"}), 200  # 200 OK

        else:
            return jsonify({"message": "Invalid credentials"}), 401 # 401 Unauthorized

    except Exception as e:
        print(f"An error occurred: {e}") #Good practice to log errors
        return jsonify({"message": "An error occurred"}), 500  # 500 Internal Server Error
    
if __name__ == "__main__":
    app.run(debug=True, port=9090)