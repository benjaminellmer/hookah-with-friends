import "package:hookah_with_friends/model/session_invite_user.dart";

import "../enum/invitation_state.dart";
import "coal_timer.dart";
import "participant.dart";
import "tobacco.dart";
import "user.dart";

class Session {
  Session(
      {required this.host,
      required this.currentTobacco,
      required this.startTime,
      DateTime? tobaccoStartTime,
      DateTime? tobaccoEndTime,
      this.endTime,
      this.coalTimer,
      List<Tobacco>? smokedTobaccos,
      this.inviteUsers = const <SessionInviteUser>[]}) {
    if (smokedTobaccos != null) {
      this.smokedTobaccos = smokedTobaccos;
    }
    this.tobaccoStartTime = tobaccoStartTime ?? startTime;
    this.tobaccoEndTime = tobaccoEndTime ?? startTime.add(sessionDuration);
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      host: User.fromJson(json["host"] as Map<String, dynamic>),
      currentTobacco:
          Tobacco.fromJson(json["currentTobacco"] as Map<String, dynamic>),
      startTime: DateTime.parse(json["startTime"] as String),
      tobaccoStartTime: DateTime.parse(json["tobaccoStartTime"] as String),
      endTime: json["endTime"] is String
          ? DateTime.parse(json["endTime"] as String)
          : null,
      tobaccoEndTime: DateTime.parse(json["tobaccoEndTime"] as String),
      coalTimer: json["coalTimer"] is Map<String, dynamic>
          ? CoalTimer.fromJson(json["coalTimer"] as Map<String, dynamic>)
          : null,
      inviteUsers: SessionInviteUser.decodeList(json["invitations"]),
    );
  }

  static const Duration sessionDuration = Duration(hours: 1, minutes: 30);

  final User host;
  Tobacco currentTobacco;
  final DateTime startTime;
  DateTime? endTime;
  late DateTime tobaccoStartTime;
  late DateTime tobaccoEndTime;
  List<Tobacco> smokedTobaccos = [];
  CoalTimer? coalTimer;
  List<SessionInviteUser> inviteUsers;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "host": host.toJson(),
        "currentTobacco": currentTobacco.toJson(),
        "startTime": startTime.toIso8601String(),
        "coalTimer": coalTimer?.toJson(),
        "endTime": endTime?.toIso8601String(),
        "tobaccoStartTime": tobaccoStartTime.toIso8601String(),
        "tobaccoEndTime": tobaccoEndTime.toIso8601String(),
        "invitations": SessionInviteUser.encodeList(inviteUsers)
      };

  List<Participant> get participants {
    final List<Participant> result = <Participant>[
      Participant(
        host.userName,
        invitationState: InvitationState.accepted,
        isHost: true,
      ),
    ];

    for (final SessionInviteUser invite in inviteUsers) {
      result.add(
        Participant(
          invite.userName,
          invitationState: invite.invitationState,
        ),
      );
    }

    return result;
  }

  double get progress {
    final DateTime now = DateTime.now();
    if (now.isBefore(tobaccoStartTime)) {
      return 0;
    }
    if (now.isAfter(tobaccoEndTime)) {
      return 1;
    } else {
      final Duration duration = tobaccoEndTime.difference(tobaccoStartTime);
      final Duration elapsed = now.difference(tobaccoStartTime);
      return elapsed.inMilliseconds / duration.inMilliseconds;
    }
  }

  Duration get timeUntilStart {
    return startTime.difference(DateTime.now());
  }

  Duration get totalDuration {
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    return DateTime.now().difference(startTime);
  }

  Duration get activeTime {
    return DateTime.now().difference(tobaccoStartTime);
  }

  int get numberOfParticipants {
    return inviteUsers
            .where((SessionInviteUser invite) =>
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
          tobaccoStartTime: session.tobaccoStartTime,
          tobaccoEndTime: session.tobaccoEndTime,
          smokedTobaccos: session.smokedTobaccos,
          coalTimer: session.coalTimer,
          inviteUsers: session.inviteUsers,
        );

  final String sessionId;
}
