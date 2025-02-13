import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientService {
  static Future<http.Response> registrar(
    BuildContext context, {
    required String name,
    required String lastName,
    required String dni,
    required String address,
  }) async {
    final url = Uri.parse('http://localhost:9090/register-client');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name'     : name,
          'lastName' : lastName,
          'dni'      : dni,
          'address'  : address,
        }),
      );

      log('Response: ${response.statusCode} - ${response.body}');
      return response;
    } catch (e) {
      log('Error: $e');
      return http.Response('Error al registrar cliente', 500);
    }
  }
}
