import '../../domain/service/i_authentication_service.dart';
import '../../domain/service/authentication_service_state.dart';
import '../../domain/service/response.dart';
import 'api_route.dart';

import 'dart:developer';
import 'package:http/http.dart' as http show post;
import 'dart:convert';
import 'dart:async';

class AuthenticationService implements IAuthenticationService {
  final String apiHost;
  Duration timeoutInSeconds;

  AuthenticationService(this.apiHost, this.timeoutInSeconds);

  void setTimeout(int durationInSeconds){
    timeoutInSeconds = Duration(seconds: durationInSeconds);
  }

  @override
  Future<Response> login(
      {required String email, required String password}) async {
    final url = Uri.parse(apiHost + ApiRoute.login.message);

    log('email: $email, password: $password');

    try {
      final response = await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      )
          .timeout(
        timeoutInSeconds,
        onTimeout: () {
          log('⏳ Request timed out');
          throw TimeoutException('Request timed out');
        },
      );

      final Map<String, dynamic> decodedBody = jsonDecode(response.body);
      final AuthenticationServiceState state =
          AuthenticationServiceState.mapStatusCodeToState(response.statusCode);

      log('🔄 Response: ${response.statusCode} - ${decodedBody['message'] ?? state.value}');
      if (response.statusCode != 200) {
        throw Exception(state.value);
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
}
