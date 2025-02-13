// ignore_for_file: use_build_context_synchronously

import 'package:app/Application/State/authentication_state.dart';
import 'package:app/Infrastructure/Service/authentication_service.dart';
import 'package:app/Presentation/router/router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationUseCase extends StateNotifier<AuthenticationState> {
  AuthenticationUseCase() : super(AuthenticationState.initial);

  Future<void> login(
      BuildContext context, String username, String password) async {
    state = AuthenticationState.loading;

    try {
      final response = await AuthenticationService.login(
        context,
        email: username,
        password: password,
      );
      // Print the entire response (status code and body)
      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        PageRouter.goToPage(context, page: Pages.welcome);
        state = AuthenticationState.success;
      } else {
        state = AuthenticationState.error;
      }
    } catch (e) {
      state = AuthenticationState.error;
    }
  }
}

final authenticationProvider =
    StateNotifierProvider<AuthenticationUseCase, AuthenticationState>(
  (ref) => AuthenticationUseCase(),
);
