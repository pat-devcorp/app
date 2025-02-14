import 'package:app/Domain/Service/iauthentication_service.dart';

import '../../Domain/Service/authentication_service_state.dart';
import '../../Domain/Model/response.dart';
import 'api_route.dart';

import 'dart:developer';
import 'package:http/http.dart' as http show post;
import 'dart:convert';

class AuthenticationService implements IAuthenticationService {
  String apiHost;

  AuthenticationService(this.apiHost);

  @override
  Future<Response> login({required String email, required String password}) async {
    final url = Uri.parse(apiHost + ApiRoute.login.message);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final Map<String, dynamic> decodedBody = jsonDecode(response.body);
      final AuthenticationServiceState state = _mapStatusCodeToState(response.statusCode);

      log('🔄 Response: ${response.statusCode} - ${decodedBody['message'] ?? state.message}');
      if (response.statusCode != 200) {
        throw Exception(state.message);
      }

      return Response(
        success: true,
        data: decodedBody,
      );
    } catch (e) {
      log('⚠️ Error during login request: $e');
      return Response(
        success: false,
        data: {'message': e.toString()},
      );
    }
  }

  static AuthenticationServiceState _mapStatusCodeToState(int statusCode) {
    switch (statusCode) {
      case 200:
        return AuthenticationServiceState.success;
      case 400:
        return AuthenticationServiceState.invalidArguments;
      case 401:
        return AuthenticationServiceState.invalidCredentials;
      case 500:
        return AuthenticationServiceState.serverError;
      default:
        return AuthenticationServiceState.notCatch;
    }
  }
}
