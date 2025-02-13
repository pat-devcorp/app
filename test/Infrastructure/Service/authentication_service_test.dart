import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Check if the server is running', () async {
    final uri = Uri.parse('http://localhost:9090/health');

    try {
      final response = await http.get(uri);

      // Check if status code is 200 (OK)
      expect(response.statusCode, 200,
          reason: 'Server is not running or responding incorrectly');

      // print('✅ Server is running: ${response.body}');
    } catch (e) {
      // Handle network errors (e.g., server not running)
      fail('❌ Failed to connect to the server: $e');
    }
  });
}
