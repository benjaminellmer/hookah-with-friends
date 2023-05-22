import "../enum/invitation_state.dart";
import "coal_timer.dart";
import "participant.dart";
import "session_invite.dart";
import "tobacco.dart";
import "user.dart";

class Session {
  Session(
      {required this.host,
      required this.currentTobacco,
      required this.startTime,
      DateTime? burnDownTime,
      this.endTime,
      this.coalTimer,
      this.smokedTobaccos = const <Tobacco>[],
      this.sessionInvites = const <SessionInvite>[]}) {
    this.burnDownTime =
        burnDownTime ?? startTime.add(const Duration(hours: 1, minutes: 30));
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      host: User.fromJson(json["host"] as Map<String, dynamic>),
      currentTobacco:
          Tobacco.fromJson(json["currentTobacco"] as Map<String, dynamic>),
      startTime: DateTime.parse(json["startTime"] as String),
      endTime: json["endTime"] is String
          ? DateTime.parse(json["endTime"] as String)
          : null,
      // burnDownTime: DateTime.parse(json["burnDownTime"] as String),
    );
  }

  final User host;
  final Tobacco currentTobacco;
  final DateTime startTime;
  DateTime? endTime;
  late final DateTime burnDownTime;
  final List<Tobacco> smokedTobaccos;
  final CoalTimer? coalTimer;
  final List<SessionInvite> sessionInvites;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "host": host.toJson(),
        "currentTobacco": currentTobacco.toJson(),
        "startTime": startTime.toIso8601String(),
        "coalTimer": coalTimer?.toJson(),
        "endTime": endTime?.toIso8601String(),
        "burnDownTime": burnDownTime,
      };

  List<Participant> get participants {
    final List<Participant> result = <Participant>[
      Participant(
        host.userName,
        invitationState: InvitationState.accepted,
        isHost: true,
      ),
    ];

    // for (final SessionInvite invite in sessionInvites) {
    //   result.add(
    //     Participant(
    //       invite.user.userName,
    //       invitationState: invite.invitationState,
    //     ),
    //   );
    // }

    return result;
  }

  double get progress {
    final DateTime now = DateTime.now();
    if (now.isBefore(startTime)) {
      return 0;
    }
    if (now.isAfter(burnDownTime)) {
      return 1;
    } else {
      final Duration duration = burnDownTime.difference(startTime);
      final Duration elapsed = now.difference(startTime);
      return elapsed.inMilliseconds / duration.inMilliseconds;
    }
  }

  // Duration get timeLeft {
  //   final DateTime now = DateTime.now();
  //   if (now.isAfter(startTime) && now.isBefore(burnDownTime)) {
  //     return burnDownTime.difference(now);
  //   } else {
  //     return Duration.zero;
  //   }
  // }

  Duration get totalDuration {
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    return DateTime.now().difference(startTime);
  }

  Duration get activeTime {
    return DateTime.now().difference(startTime);
  }

  int get numberOfParticipants {
    return sessionInvites
            .where((SessionInvite invite) =>
                invite.invitationState == InvitationState.accepted)
            .toList()
            .length +
        1;
  }
}

class SessionLoaded extends Session {
  SessionLoaded({
    required Session session,
    required this.sessionId,
  }) : super(
          host: session.host,
          currentTobacco: session.currentTobacco,
          startTime: session.startTime,
          endTime: session.endTime,
          burnDownTime: session.burnDownTime,
          smokedTobaccos: session.smokedTobaccos,
          coalTimer: session.coalTimer,
          sessionInvites: session.sessionInvites,
        );

  final String sessionId;
}
