part of "sessions_bloc.dart";

@immutable
abstract class SessionsState {}

class SessionsLoading extends SessionsState {}

class SessionsLoaded extends SessionsState {
  SessionsLoaded(this.activeSessions, this.mySessions, this.inviteSessions);

  final List<SessionLoaded> activeSessions;
  final List<Session> mySessions;
  final List<SessionInviteLoaded> inviteSessions;
}
