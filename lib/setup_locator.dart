import 'package:get_it/get_it.dart';

import 'domain/model/bootstrap.dart';
import 'domain/service/iauthentication_service.dart';
import 'infrastructure/rest_service/authentication_service.dart';
import 'presentation/language/ui_labels.dart';

final locator = GetIt.instance;

void setupLocator(Bootstrap bootstrap, UiLabels labels) {
  locator.registerLazySingleton<IAuthenticationService>(
      () => AuthenticationService(bootstrap.apiHost));

  locator.registerLazySingleton<UiLabels>(() => labels);
}
