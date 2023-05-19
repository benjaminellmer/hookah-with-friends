import "dart:async";

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

  Future<List<SessionInviteLoaded>> loadInvites() async {
    final List<SessionInviteLoaded> result = [];

    for (final SessionInvite invite in userService.currentUser!.invitations) {
      final DocumentSnapshot<Map<String, dynamic>> dbSession =
          await db.collection("sessions").doc(invite.sessionId).get();
      final Session session = Session.fromJson(dbSession.data()!);
      result.add(SessionInviteLoaded(
        session: session,
        sessionId: invite.sessionId,
        invitationState: invite.invitationState,
      ));
    }

    return result;
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
