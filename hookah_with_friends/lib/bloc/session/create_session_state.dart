part of "create_session_cubit.dart";

@immutable
abstract class CreateSessionState {}

class CreateSessionLoading extends CreateSessionState {}

class CreateSessionSuccess extends CreateSessionState {}

class CreateSessionLoaded extends CreateSessionState {
  CreateSessionLoaded(this.tobaccos, this.friends);

  final List<Tobacco> tobaccos;
  final List<User> friends;
}

class CreateSessionError extends CreateSessionState {
  CreateSessionError({required this.errorMessage, this.isCritical = false});

  final String errorMessage;
  final bool isCritical;
}
