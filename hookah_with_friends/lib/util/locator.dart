import "package:get_it/get_it.dart";

import "../services/auth_service.dart";
import "../services/session_service.dart";
import "../services/tobacco_service.dart";
import "../services/user_service.dart";

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerLazySingleton<UserService>(UserService.new)
    ..registerLazySingleton(AuthService.new)
    ..registerLazySingleton<TobaccoService>(TobaccoService.new)
    ..registerLazySingleton<SessionService>(SessionService.new);
}
