part of "active_session_cubit.dart";

@immutable
abstract class ActiveSessionState {}

class ActiveSessionLoaded extends ActiveSessionState {
  ActiveSessionLoaded(this.session);

  final SessionLoaded session;
}

class ActiveSessionLoadedRenewTobacco extends ActiveSessionLoaded {
  ActiveSessionLoadedRenewTobacco(super.session,
      {required this.availableTobaccos});

  final List<Tobacco> availableTobaccos;
}

class ActiveSessionFinished extends ActiveSessionState {}
