import '../../domain/service/base_service_status.dart';
import '../../domain/service/iauthentication_service.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationUseCase extends StateNotifier<BaseServiceStatus> {
  final IAuthenticationService _authenticationService;
  AuthenticationUseCase(this._authenticationService)
      : super(BaseServiceStatus.init);

  Future<void> login(
      BuildContext context, String username, String password) async {
    state = BaseServiceStatus.loading;

    try {
      final response = await _authenticationService.login(
        email: username,
        password: password,
      );

      if (response.success) {
        state = BaseServiceStatus.success;
      } else {
        log('⚠️ Authentication failed: ${response.data}');
        state = BaseServiceStatus.error;
      }
    } catch (e) {
      state = BaseServiceStatus.error;
    }
  }

  void logout() {
    state = BaseServiceStatus.error;
  }
}
