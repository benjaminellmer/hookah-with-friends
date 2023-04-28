import "../../enum/flavour.dart";
import "../../enum/invitation_state.dart";
import "../../model/session.dart";
import "../../model/session_invite.dart";
import "../../model/tobacco.dart";
import "../../model/user.dart";

// ignore: avoid_classes_with_only_static_members
class TestData {
  static User hookahUser = User(
    firebaseId: "",
    userName: "HookahUser",
    email: "hookahuser@trustshisha.com",
    motto: "A Hookah a day keeps the cancer away!",
  );

  static User activeUser = User(
    firebaseId: "",
    userName: "Hannes",
    email: "hannes@gmail.com",
    motto: "A Hookah a day keeps the cancer away!",
  );

  static User yoloBenji = User(
    firebaseId: "",
    userName: "YoloBenji",
    email: "hannes@gmail.com",
    motto: "A Hookah a day keeps the cancer away!",
  );

  static User benjiNaut = User(
    firebaseId: "",
    userName: "BenjiNaut",
    email: "benjiNaut@gmail.com",
    motto: "A Hookah a day keeps the cancer away!",
  );

  static User redBauerRanger = User(
    firebaseId: "",
    userName: "RedBauerRanger",
    email: "redBauerRanger@gmail.com",
    motto: "A Hookah a day keeps the cancer away!",
  );

  static User drunkDriver = User(
    firebaseId: "",
    userName: "DrunkDriver",
    email: "drunkdriver@gmail.com",
    motto: "A Hookah a day keeps the cancer away!",
  );

  static User soberDriver = User(
    firebaseId: "",
    userName: "SoberDriver",
    email: "drunkdriver@gmail.com",
    motto: "A Hookah a day keeps the cancer away!",
  );

  static Tobacco blackNana = Tobacco(
    name: "Black Nana",
    brand: "Nameless",
    flavours: <Flavour>[Flavour.mint, Flavour.grape],
  );

  static Tobacco blackChai = Tobacco(
    name: "Black Chai",
    brand: "Nameless",
    flavours: <Flavour>[Flavour.grape],
  );

  static Tobacco greenLights = Tobacco(
    name: "Green Lights",
    brand: "187",
    flavours: <Flavour>[Flavour.grape],
  );

  static Tobacco juicyPuzzy = Tobacco(
    name: "Juicy Puzzy",
    brand: "187",
    flavours: <Flavour>[Flavour.grape],
  );

  static Tobacco holyTropical = Tobacco(
    name: "Holy Tropical",
    brand: "187",
    flavours: <Flavour>[Flavour.grape],
  );

  static Tobacco redLights = Tobacco(
    name: "Red Lights",
    brand: "187",
    flavours: <Flavour>[Flavour.grape],
  );

  static Session get activeSession {
    final Session session = Session(
      startTime: DateTime.now().subtract(const Duration(minutes: 55)),
      host: hookahUser,
      currentTobacco: blackNana,
    );

    session.sessionInvites.add(
      SessionInvite(
        user: benjiNaut,
        invitationState: InvitationState.accepted,
        session: futureSession1,
      ),
    );

    return session;
  }

  static Session futureSession1 = Session(
    startTime: DateTime.now().add(const Duration(hours: 1)),
    host: hookahUser,
    currentTobacco: blackNana,
  );

  static Session futureSession2 = Session(
    startTime: DateTime.now().add(const Duration(hours: 2)),
    host: hookahUser,
    currentTobacco: blackNana,
  );

  static SessionInvite sessionInvite1 = SessionInvite(
    user: activeUser,
    invitationState: InvitationState.accepted,
    session: futureSession1,
  );

  static SessionInvite sessionInvite2 = SessionInvite(
    user: activeUser,
    invitationState: InvitationState.declined,
    session: futureSession2,
  );

  static Session historySession1 = Session(
    startTime: DateTime.now().subtract(const Duration(days: 5)),
    endTime: DateTime.now()
        .subtract(const Duration(days: 5))
        .add(const Duration(hours: 5, minutes: 26, seconds: 47)),
    host: hookahUser,
    currentTobacco: blackNana,
    smokedTobaccos: <Tobacco>[blackNana, blackNana, blackNana],
  );

  static List<Tobacco> tobaccos = <Tobacco>[
    blackNana,
    blackChai,
    greenLights,
    juicyPuzzy,
    holyTropical,
    redLights,
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

  static List<User> inviteList = <User>[
    drunkDriver,
    soberDriver,
  ];

  static List<User> friendList = <User>[
    hookahUser,
    activeUser,
    benjiNaut,
    yoloBenji,
    redBauerRanger
  ];

  static List<Session> historySessionList = <Session>[
    historySession1,
  ];
}
