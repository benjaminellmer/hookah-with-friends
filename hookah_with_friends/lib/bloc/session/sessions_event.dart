part of "sessions_bloc.dart";

@immutable
abstract class SessionsEvent {}

class SessionsLoadInitialized extends SessionsEvent {}

class SessionsRefreshInitialized extends SessionsEvent {}
