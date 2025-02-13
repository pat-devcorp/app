import 'dart:convert';
import 'dart:developer';

import 'package:app/Infrastructure/Service/api_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Check if the server is running', () async {
    final url = Uri.parse( "http://localhost:9090/health${ApiRoute.login}");

    try {
      final response = await http.get(url);

      // Check if status code is 200 (OK)
      expect(response.statusCode, 200,
          reason: 'Server is not running or responding incorrectly');

      // Parse JSON response
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Validate required keys
      expect(responseBody.containsKey('ok'), isTrue,
          reason: 'Missing "ok" field');
      expect(responseBody.containsKey('message'), isTrue,
          reason: 'Missing "message" field');

      // Validate 'ok' field type (should be int)
      expect(responseBody['ok'], isA<int>(), reason: '"ok" should be an integer');

      if (response.statusCode == 200) {
        // If 200, additional fields should exist
        expect(responseBody.containsKey('host'), isTrue,
            reason: 'Missing "host" field in successful response');
        expect(responseBody.containsKey('pid'), isTrue,
            reason: 'Missing "pid" field in successful response');
        expect(responseBody.containsKey('services'), isTrue,
            reason: 'Missing "services" field in successful response');

        // Validate 'services' structure
        expect(responseBody['services'], isA<Map<String, dynamic>>(),
            reason: '"services" should be a map');
      }

      log('✅ Server is running: ${response.body}');
    } catch (e) {
      // Handle network errors (e.g., server not running)
      fail('❌ Failed to connect to the server: $e');
    }
  });
}
