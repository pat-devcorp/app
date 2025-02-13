import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http show Response, post;
import 'dart:convert';

class AuthenticationService {
  static Future<http.Response> login(BuildContext context,
      {required String email, required String password}) async {
    final url = Uri.parse('http://localhost:9090/login'); // Your API endpoint
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      try {
        final decodedBody = jsonDecode(response.body); // Decode JSON
        if (response.statusCode == 200) {
          String message = decodedBody['message']; // Access the 'message' field
          log('Message from server: $message');
          return response; // Return the response object
        } else {
          // Retornar la respuesta incluso si el status code no es 200
          log('Error: ${response.statusCode} - ${response.body}');
          return response;
        }
      } catch (e) {
        log('Error decoding JSON: $e');
        return http.Response('Error decoding JSON', 500);
      }
    } catch (e) {
      log('Error during login request: $e');
      return http.Response('Error during login request', 500);
    }
  }
}
