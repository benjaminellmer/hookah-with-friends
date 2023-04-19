import "../../enum/availability.dart";
import "../../enum/invitation_state.dart";
import "../../model/friend.dart";
import "../../model/participant.dart";
import "../../model/session.dart";
import "../../model/tobacco.dart";
import "../../model/user.dart";

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

  static List<Tobacco> tobaccos = <Tobacco>[
    Tobacco(name: "Black Nana", brand: "Nameless"),
    Tobacco(name: "K!W!CK", brand: "Nameless"),
    Tobacco(name: "Black Chai", brand: "Nameless"),
    Tobacco(name: "Green Lights", brand: "187"),
    Tobacco(name: "Juicy Puzzy", brand: "187"),
    Tobacco(name: "Holy Tropical", brand: "187"),
    Tobacco(name: "Red Light", brand: "187"),
  ];

  static List<String> friends = <String>[
    "Hannes",
    "YoloBenji",
    "KopfalNorbert",
    "TraubenDaniel",
    "Simon",
    "Benji",
    "Jakob",
    "David",
  ];

  static List<String> flavours = <String>[
    "Grape",
    "Mint",
    "Watermelon",
    "Ice (Menthol)",
    "Strawberry",
    "Banana",
    "Lemon",
    "Mixed Fruits",
  ];

  static User testuser = User(
      username: "HookahUser",
      motto: "A hookah a day keeps the cancer away",
      friends: "17",
      invites: "2",
      sessions: "37");

  static List<Friend> friendList = [
    Friend(name: "KopfalNorbert"),
    Friend(name: "Hannes"),
    Friend(name: "YoloBenji"),
    Friend(name: "Benjinaut"),
    Friend(name: "RedBauerRanger"),
  ];

  static List<Friend> inviteList = [
    Friend(name: "DrunkDriver"),
    Friend(name: "SoberDriver"),
  ];

  static List<Session> historySessionList = [
    Session(
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
        tobaccoCount: 5),
    Session(
        host: "RedBauerRanger",
        tobacco: Tobacco(
          name: "Dark City Lights",
          availability: Availability.high,
          brand: "Nameless",
        ),
        participants: <Participant>[
          Participant("Simon", invitationState: InvitationState.accepted),
          Participant("Jakob", invitationState: InvitationState.accepted),
          Participant("David", invitationState: InvitationState.accepted),
        ],
        startTime: DateTime.now().subtract(const Duration(days: 5)),
        endTime: DateTime.now()
            .subtract(const Duration(days: 5))
            .add(const Duration(hours: 3, minutes: 17, seconds: 35)),
        invitationState: InvitationState.accepted,
        tobaccoCount: 3),
    Session(
        host: "Hannes",
        tobacco: Tobacco(
          name: "Cold Melo",
          availability: Availability.medium,
          brand: "7 Days",
        ),
        participants: <Participant>[
          Participant("Simon", invitationState: InvitationState.accepted),
          Participant("Jakob", invitationState: InvitationState.accepted),
          Participant("David", invitationState: InvitationState.accepted),
          Participant("Jakob", invitationState: InvitationState.accepted),
          Participant("David", invitationState: InvitationState.accepted),
          Participant("Hannes", invitationState: InvitationState.accepted),
          Participant("Gichtlsepp", invitationState: InvitationState.accepted),
        ],
        startTime: DateTime.now().subtract(const Duration(days: 6)),
        endTime: DateTime.now()
            .subtract(const Duration(days: 6))
            .add(const Duration(hours: 7, minutes: 45, seconds: 12)),
        invitationState: InvitationState.accepted,
        tobaccoCount: 9),
  ];
  static Tobacco tobacco1 = Tobacco(name: "BlackNana", availability: Availability.high, brand: "Nameless");
  static Tobacco tobacco2 = Tobacco(name: "Adam&Eve", availability: Availability.medium, brand: "Nameless");
}
