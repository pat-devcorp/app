import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Application/State/authentication_state.dart';
import '../../Application/UseCase/authentication_use_case.dart';
import '../../Domain/Service/iauthentication_service.dart';
import '../../locator.dart';

final authenticationProvider =
StateNotifierProvider<AuthenticationUseCase, AuthenticationState>(
      (ref) => AuthenticationUseCase(locator<IAuthenticationService>()),
);