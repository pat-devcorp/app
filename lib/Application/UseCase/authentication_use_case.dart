import 'dart:developer';

import '../../Application/State/authentication_state.dart';
import '../../Domain/Service/iauthentication_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationUseCase extends StateNotifier<AuthenticationState> {
  final IAuthenticationService _authenticationService;
  AuthenticationUseCase(this._authenticationService) : super(AuthenticationState.unauthenticated);

  Future<void> login(
      BuildContext context, String username, String password) async {
    state = AuthenticationState.loading;

    try {
      final response = await _authenticationService.login(
        email: username,
        password: password,
      );

      if (response.success) {
        state = AuthenticationState.authenticated;
      } else {
        log('⚠️ Authentication failed: ${response.data}');
        state = AuthenticationState.error;
      }
    } catch (e) {
      state = AuthenticationState.error;
    }
  }

  void logout() {
    state = AuthenticationState.unauthenticated;
  }
}
