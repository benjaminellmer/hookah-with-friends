import "package:cloud_firestore/cloud_firestore.dart";

import "../model/session.dart";
import "../model/session_invite.dart";
import "../model/user.dart";
import "../util/locator.dart";
import "user_service.dart";

class SessionService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserService userService = getIt.get<UserService>();

  Future<void> createSession(Session session, List<User> invitedFriends) async {
    final DocumentReference<Map<String, dynamic>> ref =
        await db.collection("sessions").add(session.toJson());
    await sendInvitations(invitedFriends: invitedFriends, sessionId: ref.id);
  }

  Future<void> sendInvitations(
      {required List<User> invitedFriends, required String sessionId}) async {
    final QuerySnapshot<Map<String, dynamic>> invitedUsers = await db
        .collection("users")
        .where("uid", whereIn: invitedFriends.map((e) => e.uid))
        .get();

    final SessionInvite invite = SessionInvite(sessionId: sessionId);

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in invitedUsers.docs) {
      final User user = User.fromJson(doc.data());
      user.invitations.add(invite);
      doc.reference.set(user.toJson());
    }
  }
}
