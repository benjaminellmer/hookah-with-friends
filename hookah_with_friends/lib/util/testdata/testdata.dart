import "../../enum/availability.dart";
import "../../enum/invitation_state.dart";
import "../../model/participant.dart";
import "../../model/session.dart";
import "../../model/tobacco.dart";

// ignore: avoid_classes_with_only_static_members
class TestData {
  static Session activeSession = Session(
    host: "Benjamin",
    tobacco: Tobacco(
      name: "Black Nana",
      availability: Availability.high,
      brand: "Nameless",
    ),
    participants: <Participant>[
      Participant("YoloBenji", invitationState: InvitationState.accepted),
      Participant("KopfalNorbert"),
      Participant("RedBauerRanger", invitationState: InvitationState.declined),
    ],
    startTime: DateTime.now().subtract(const Duration(minutes: 55)),
    endTime: DateTime.now().add(const Duration(minutes: 10)),
  );

  static Session inviteSession1 = Session(
    host: "KopfalNorbert",
    tobacco: Tobacco(
      name: "Black Nana",
      availability: Availability.high,
      brand: "Nameless",
    ),
    participants: <Participant>[
      Participant("Hannes", invitationState: InvitationState.accepted),
      Participant("YoloBenji", invitationState: InvitationState.accepted),
      Participant("KopfalNorbert"),
      Participant("TraubenDaniel", invitationState: InvitationState.declined),
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
      brand: "Nameless",
    ),
    participants: <Participant>[
      Participant("Simon"),
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
        brand: "Nameless",
      ),
      participants: <Participant>[
        Participant("Simon", invitationState: InvitationState.accepted),
        Participant("Jakob", invitationState: InvitationState.accepted),
        Participant("David", invitationState: InvitationState.accepted),
        Participant("Jakob", invitationState: InvitationState.accepted),
        Participant("David", invitationState: InvitationState.accepted),
      ],
      startTime: DateTime.now().subtract(const Duration(days: 5)),
      endTime: DateTime.now()
          .subtract(const Duration(days: 5))
          .add(const Duration(hours: 5, minutes: 26, seconds: 47)),
      invitationState: InvitationState.accepted,
      tobaccoCount: 5);

  static Tobacco tobacco1 = Tobacco(name: "BlackNana", availability: Availability.high, brand: "Nameless");
}
