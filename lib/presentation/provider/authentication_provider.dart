import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/service/base_service_status.dart';
import '../../application/use_case/authentication_use_case.dart';
import '../../domain/service/i_authentication_service.dart';
import '../../setup_locator.dart';

final authenticationProvider =
    StateNotifierProvider<AuthenticationUseCase, BaseServiceStatus>(
  (ref) => AuthenticationUseCase(locator<IAuthenticationService>()),
);
