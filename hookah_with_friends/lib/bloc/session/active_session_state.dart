part of "active_session_cubit.dart";

@immutable
abstract class ActiveSessionState {}

class ActiveSessionInitial extends ActiveSessionState {}

class ActiveSessionFinished extends ActiveSessionState {}
