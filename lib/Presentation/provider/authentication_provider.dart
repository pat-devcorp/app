import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Domain/Model/base_service_status.dart';
import '../../Application/UseCase/authentication_use_case.dart';
import '../../Domain/Service/iauthentication_service.dart';
import '../../locator.dart';

final authenticationProvider =
    StateNotifierProvider<AuthenticationUseCase, BaseServiceStatus>(
  (ref) => AuthenticationUseCase(locator<IAuthenticationService>()),
);
