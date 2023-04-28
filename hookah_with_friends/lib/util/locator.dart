import "package:get_it/get_it.dart";

import "../services/auth_service.dart";
import "../services/session_service.dart";

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerSingleton(AuthService())
    ..registerLazySingleton<SessionService>(SessionService.new);
}
