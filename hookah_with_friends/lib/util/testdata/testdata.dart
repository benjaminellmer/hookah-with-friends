import "../../enum/availability.dart";
import "../../enum/invitation_state.dart";
import "../../model/session.dart";
import "../../model/tobacco.dart";

// ignore: avoid_classes_with_only_static_members
class TestData {
  static Session activeSession = Session(
    host: "Benjamin",
    tobacco: Tobacco(
      name: "Black Nana",
      availability: Availability.high,
    ),
    participants: <String>[
      "Simon",
      "Jakob",
      "David",
    ],
    startTime: DateTime.now().subtract(const Duration(minutes: 55)),
    endTime: DateTime.now().add(const Duration(minutes: 10)),
  );

  static Session inviteSession1 = Session(
    host: "KopfalNorbert",
    tobacco: Tobacco(
      name: "Black Nana",
      availability: Availability.high,
    ),
    participants: <String>[
      "Simon",
      "Jakob",
      "David",
    ],
    startTime: DateTime.now().add(const Duration(hours: 1)),
    endTime: DateTime.now().add(const Duration(hours: 3)),
    invitationState: InvitationState.accepted,
  );

  static Session inviteSession2 = Session(
    host: "Hannes",
    tobacco: Tobacco(
      name: "Black Nana",
      availability: Availability.high,
    ),
    participants: <String>[
      "Simon",
    ],
    startTime: DateTime.now().add(const Duration(hours: 3)),
    endTime: DateTime.now().add(const Duration(hours: 5)),
    invitationState: InvitationState.declined,
  );

  static Session historySession = Session(
    host: "KopfalNorbert",
    tobacco: Tobacco(
      name: "Black Nana",
      availability: Availability.high,
    ),
    participants: <String>[
      "Simon",
      "Jakob",
      "David",
      "David",
      "David",
    ],
    startTime: DateTime.now().subtract(const Duration(days: 5)),
    endTime: DateTime.now()
        .subtract(const Duration(days: 5))
        .add(const Duration(hours: 5, minutes: 26, seconds: 47)),
    invitationState: InvitationState.accepted,
    tobaccoCount: 5
  );
}
