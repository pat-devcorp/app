import 'package:app/Domain/Model/bootstrap.dart';
import 'package:get_it/get_it.dart';

import 'Domain/Service/iauthentication_service.dart';
import 'Infrastructure/Service/authentication_service.dart';
import 'Presentation/language/localization_service.dart';

final locator = GetIt.instance;

void setupLocator(Bootstrap bootstrap) {
  locator.registerLazySingleton<IAuthenticationService>(() => AuthenticationService(bootstrap.apiHost));
  locator.registerSingleton<LocalizationService>(LocalizationService.fromJson(bootstrap.labelStrings));
}