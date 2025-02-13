// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:app/Application/State/authentication_state.dart';
import 'package:app/Domain/Service/iauthentication_service.dart';
import 'package:app/Presentation/router/router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../locator.dart';

class AuthenticationUseCase extends StateNotifier<AuthenticationState> {
  final IAuthenticationService _authenticationService;
  AuthenticationUseCase(this._authenticationService) : super(AuthenticationState.initial);

  Future<void> login(
      BuildContext context, String username, String password) async {
    state = AuthenticationState.loading;

    try {
      final response = await _authenticationService.login(
        email: username,
        password: password,
      );

      if (response.success) {
        PageRouter.goToPage(context, page: Pages.welcome);
        state = AuthenticationState.success;
      } else {
        log('⚠️ Authenti ation failed: ${response.data}');
        state = AuthenticationState.error;
      }
    } catch (e) {
      state = AuthenticationState.error;
    }
  }
}

final authenticationProvider =
StateNotifierProvider<AuthenticationUseCase, AuthenticationState>(
      (ref) => AuthenticationUseCase(locator<IAuthenticationService>()),
);
