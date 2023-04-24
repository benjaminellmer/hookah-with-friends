import "package:hookah_with_friends/model/participant.dart";

import "../enum/availability.dart";
import "../enum/flavour.dart";
import "../enum/invitation_state.dart";
import "coal_timer.dart";

class User {
  User({
    required this.userName,
    required this.firebaseId,
    required this.email,
    required this.motto,
  });

  final String firebaseId;
  final String userName;
  final String email;
  final String motto;

  List<String> get friends {
    return [""];
  }
}

class Session {
  Session({
    required this.host,
    required this.currentTobacco,
    required this.startTime,
    required this.sessionInvites,
    this.endTime,
    this.coalTimer,
    this.smokedTobaccos = const <Tobacco>[],
  }) {
    burnDownTime = startTime.add(const Duration(hours: 1, minutes: 30));
  }

  final User host;
  final Tobacco currentTobacco;
  final DateTime startTime;
  final DateTime? endTime;
  late final DateTime burnDownTime;
  final List<Tobacco> smokedTobaccos;
  final CoalTimer? coalTimer;
  final List<SessionInvite> sessionInvites;

  List<Participant> get participants {
    final List<Participant> result = <Participant>[
      Participant(
        host.userName,
        invitationState: InvitationState.accepted,
        isHost: true,
      ),
    ];

    for (final SessionInvite invite in sessionInvites) {
      result.add(
        Participant(
          invite.user.userName,
          invitationState: invite.invitationState,
        ),
      );
    }

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
    int result = 1; // host
    for (final Participant participant in participants) {
      if (participant.invitationState == InvitationState.accepted) {
        result++;
      }
    }
    return result;
  }
}

class SessionInvite {
  SessionInvite({
    required this.user,
    required this.invitationState,
    required this.session,
  });

  final User user;
  final Session session;
  final InvitationState invitationState;
}

abstract class UserService {
  List<Session> getActiveSessions();

  List<Session> getSessionInvites();

  List<Session> getHistorySessions();

  List<User> getFriends();
}

abstract class SessionService {
  Future<void> createSession(Session session);
}

class Tobacco {
  Tobacco({
    required this.name,
    required this.brand,
    this.availability = Availability.high,
    required this.flavours,
  });

  final String name;
  final Availability availability;
  final String brand;
  final List<Flavour> flavours;
}
