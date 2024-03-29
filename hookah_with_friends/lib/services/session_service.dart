import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";

import "../bloc/session/sessions_bloc.dart";
import "../enum/invitation_state.dart";
import "../model/session.dart";
import "../model/session_invite.dart";
import "../model/session_invite_user.dart";
import "../model/tobacco.dart";
import "../model/user.dart";
import "../util/locator.dart";
import "user_service.dart";

class SessionService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserService userService = getIt.get<UserService>();

  Future<void> createSession(Session session, List<User> invitedFriends) async {
    session.inviteUsers = invitedFriends
        .map((User e) => SessionInviteUser(
              userId: e.uid,
              userName: e.userName,
            ))
        .toList();
    final DocumentReference<Map<String, dynamic>> ref =
        await db.collection("sessions").add(session.toJson());
    await sendInvitations(invitedFriends: invitedFriends, sessionId: ref.id);
  }

  Future<void> endSession(SessionLoaded session) async {
    final DocumentSnapshot<Map<String, dynamic>> dbSession =
        await db.collection("sessions").doc(session.sessionId).get();

    final Session modifiedSession = Session.fromJson(dbSession.data()!);
    modifiedSession.endTime = DateTime.now();
    modifiedSession.tobaccoEndTime = DateTime.now();
    modifiedSession.smokedTobaccos.add(modifiedSession.currentTobacco);
    dbSession.reference.set(modifiedSession.toJson());
  }

  Future<SessionLoaded> renewTobacco(
      {required SessionLoaded session, required Tobacco newTobacco}) async {
    final DocumentSnapshot<Map<String, dynamic>> dbSession =
        await db.collection("sessions").doc(session.sessionId).get();
    if (dbSession.data() != null) {
      final Session loadedSession = Session.fromJson(dbSession.data()!);
      loadedSession.smokedTobaccos.add(session.currentTobacco);
      loadedSession.tobaccoStartTime = DateTime.now();
      loadedSession.tobaccoEndTime =
          DateTime.now().add(Session.sessionDuration);
      loadedSession.currentTobacco = newTobacco;
      dbSession.reference.set(loadedSession.toJson());
      final SessionLoaded result =
          SessionLoaded(session: loadedSession, sessionId: session.sessionId);
      session = result;
      return result;
    } else {
      return session;
    }
  }

  Future<SessionLoaded> loadSession({required String sessionId}) async {
    final DocumentSnapshot<Map<String, dynamic>> dbSession =
        await db.collection("sessions").doc(sessionId).get();
    return SessionLoaded(
      session: Session.fromJson(dbSession.data()!),
      sessionId: sessionId,
    );
  }

  Future<SessionsResult<Session>> loadMySessions() async {
    final List<Session> result = <Session>[];
    final List<SessionLoaded> activeSessions = <SessionLoaded>[];

    final QuerySnapshot<Map<String, dynamic>> dbSessions = await db
        .collection("sessions")
        .where("host.uid", isEqualTo: userService.currentUser!.uid)
        .get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in dbSessions.docs) {
      final Session session = Session.fromJson(doc.data());
      if (session.endTime == null &&
          session.startTime.isBefore(DateTime.now())) {
        activeSessions.add(SessionLoaded(session: session, sessionId: doc.id));
      } else {
        if (session.endTime == null) {
          result.add(session);
        }
      }
    }

    return SessionsResult<Session>(result, activeSessions);
  }

  Future<SessionsResult<SessionInviteLoaded>> loadInvites() async {
    final List<SessionInviteLoaded> result = <SessionInviteLoaded>[];
    final List<SessionLoaded> activeSessions = <SessionLoaded>[];

    for (final SessionInvite invite in userService.currentUser!.invitations) {
      final DocumentSnapshot<Map<String, dynamic>> dbSession =
          await db.collection("sessions").doc(invite.sessionId).get();
      if (dbSession.data() != null) {
        final Session session = Session.fromJson(dbSession.data()!);
        if (invite.invitationState == InvitationState.accepted &&
            session.startTime.isBefore(DateTime.now())) {
          if (session.endTime == null) {
            activeSessions
                .add(SessionLoaded(session: session, sessionId: dbSession.id));
          }
        } else {
          if (session.endTime == null) {
            result.add(SessionInviteLoaded(
              session: SessionLoaded(session: session, sessionId: dbSession.id),
              sessionId: invite.sessionId,
              invitationState: invite.invitationState,
            ));
          }
        }
      }
    }

    return SessionsResult<SessionInviteLoaded>(result, activeSessions);
  }

  Future<void> updateInvitationState(
      SessionLoaded session, InvitationState state) async {
    final SessionInvite invite = userService.currentUser!.invitations
        .firstWhere((SessionInvite invitation) =>
            invitation.sessionId == session.sessionId);

    invite.invitationState = state;

    final userInvites = session.inviteUsers
        .where((user) => user.userId == userService.currentUser!.uid);

    if (userInvites.isNotEmpty) {
      final userInvite = userInvites.first;
      userInvite.invitationState = state;
      await saveSession(session);
    }

    await userService.saveCurrentUser();
  }

  Future<void> sendInvitations(
      {required List<User> invitedFriends, required String sessionId}) async {
    final QuerySnapshot<Map<String, dynamic>> invitedUsers = await db
        .collection("users")
        .where("uid", whereIn: invitedFriends.map((User e) => e.uid))
        .get();

    final SessionInvite invite = SessionInvite(sessionId: sessionId);

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in invitedUsers.docs) {
      final User user = User.fromJson(doc.data());
      user.invitations.add(invite);
      doc.reference.set(user.toJson());
    }
  }

  Future<void> saveSession(SessionLoaded session) async {
    final DocumentSnapshot<Map<String, dynamic>> dbSession =
        await db.collection("sessions").doc(session.sessionId).get();

    dbSession.reference.update(session.toJson());
  }
}
