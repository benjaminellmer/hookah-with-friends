part of "sessions_bloc.dart";

@immutable
abstract class SessionsState {}

class SessionsLoading extends SessionsState {}

class SessionsRefreshing extends SessionsLoaded {
  SessionsRefreshing(
      super.activeSessions, super.mySessions, super.inviteSessions);
}

class SessionsLoaded extends SessionsState {
  SessionsLoaded(this.activeSessions, this.mySessions, this.inviteSessions);

  final List<SessionLoaded> activeSessions;
  final List<Session> mySessions;
  final List<SessionInviteLoaded> inviteSessions;
}
