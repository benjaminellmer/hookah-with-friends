import "package:hookah_with_friends/model/participant.dart";

import "../enum/availability.dart";
import "../enum/flavour.dart";
import "../enum/invitation_state.dart";
import "coal_timer.dart";

class User {
  User(this.username, this.firebaseId, this.email, this.motto);

  final String firebaseId;
  final String username;
  final String email;
  final String motto;
}

class Session {
  Session(
    this.host,
    this.currentTobacco,
    this.burnDownTime,
    this.startTime,
    this.smokedTobaccos,
    this.userInvites, {
    this.coalTimer,
  });

  final User host;
  final Tobacco currentTobacco;
  final DateTime startTime;
  final DateTime burnDownTime;
  final List<Tobacco> smokedTobaccos;
  final CoalTimer? coalTimer;
  final List<UserInvite> userInvites;

  List<Participant> get participants {
    final List<Participant> result = <Participant>[
      Participant(
        host.username,
        invitationState: InvitationState.accepted,
        isHost: true,
      ),
    ];

    for (final UserInvite invite in userInvites) {
      result.add(
        Participant(
          invite.user.username,
          invitationState: invite.invitationState,
        ),
      );
    }

    return result;
  }
}

class UserInvite {
  UserInvite(this.user, this.invitationState);

  final User user;
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
