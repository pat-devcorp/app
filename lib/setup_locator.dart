import 'package:get_it/get_it.dart';

import 'domain/model/bootstrap.dart';
import 'domain/service/i_authentication_service.dart';
import 'infrastructure/rest_service/authentication_service.dart';
import 'presentation/language/ui_labels.dart';

final locator = GetIt.instance;

void setupLocator(Bootstrap bootstrap, UiLabels labels) {
  locator.registerLazySingleton<IAuthenticationService>(
      () => AuthenticationService(bootstrap.apiHost, Duration(seconds: bootstrap.requestTimeoutInSeconds)
      ));

  locator.registerLazySingleton<UiLabels>(() => labels);
}
