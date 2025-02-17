import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../Domain/Model/response.dart';

class ClientService {
  String apiHost;

  ClientService(this.apiHost);

  Future<Response> registerClient({required String name, required String email}) async {
    final url = Uri.parse("$apiHost/client");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email}),
      );

      final Map<String, dynamic> decodedBody = jsonDecode(response.body);

      log('🔄 Response: ${response.statusCode} - ${decodedBody['message']}');

      if (response.statusCode != 200) {
        throw Exception(decodedBody['message']);
      }

      return Response(success: true, data: decodedBody);
    } catch (e) {
      log('⚠️ Error during client registration: $e');
      return Response(success: false, data: {'message': e.toString()});
    }
  }
}
