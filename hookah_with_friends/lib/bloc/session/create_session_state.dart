part of "create_session_cubit.dart";

@immutable
abstract class CreateSessionState {}

class CreateSessionInitial extends CreateSessionState {}

class CreateSessionSuccess extends CreateSessionState {}

class CreateSessionError extends CreateSessionState {
  CreateSessionError({required this.errorMessage});

  final String errorMessage;
}
