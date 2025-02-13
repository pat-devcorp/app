from flask import Flask, request, jsonify
from flask_cors import CORS
import multiprocessing
import os

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
        return 'OK', 200
    else:
        return 'Service Unavailable', 500

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
    
def run_flask():
    app.run(host='0.0.0.0', debug=True, port=int(os.environ.get('PORT', 9090)))

if __name__ == '__main__':
    flask_process = multiprocessing.Process(target=run_flask)
    flask_process.start()
