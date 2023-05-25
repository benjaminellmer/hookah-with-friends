part of "create_session_cubit.dart";

@immutable
abstract class CreateSessionState {}

class CreateSessionLoading extends CreateSessionState {}

class CreateSessionSuccess extends CreateSessionState {}

class CreateSessionLoaded extends CreateSessionState {
  CreateSessionLoaded(this.tobaccos, this.friends, {this.errorMessage});

  final List<Tobacco> tobaccos;
  final List<User> friends;
  final String? errorMessage;
}

class CreateSessionError extends CreateSessionState {
  CreateSessionError({required this.errorMessage, this.isCritical = false});

  final String errorMessage;
  final bool isCritical;
}
