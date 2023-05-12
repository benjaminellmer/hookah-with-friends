import "package:cloud_firestore/cloud_firestore.dart";

import "../exceptions/datastore_exception.dart";
import "../model/friend_invitation.dart";
import "../model/user.dart";
import "../util/locator.dart";
import "user_service.dart";

class FriendService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final UserService userService = getIt.get<UserService>();

  Future<DocumentReference<dynamic>?> createInvitation(
      {required String toUid}) {
    final String? uid = userService.currentUser?.uid;
    if (uid != null) {
      final FriendInvitation invitation =
          FriendInvitation(from: uid, to: toUid);

      return db.collection("friend_invitations").add(invitation.toJson());
    } else {
      throw DataStoreException("User is not authenticated!");
    }
  }

  Future<bool> invitationExists({required String toUid}) async {
    final QuerySnapshot<Map<String, dynamic>> invitations = await db
        .collection("friend_invitations")
        .where("from", isEqualTo: userService.currentUser?.uid)
        .where("to", isEqualTo: toUid)
        .get();

    return invitations.size != 0;
  }

  Future<List<FriendInvitationLoaded>> getMyInvitations() async {
    final List<FriendInvitation> dbInvitations = [];

    final QuerySnapshot<Map<String, dynamic>> invitations = await db
        .collection("friend_invitations")
        .where("to", isEqualTo: userService.currentUser?.uid)
        .get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> invitationJson
        in invitations.docs) {
      dbInvitations.add(FriendInvitation.fromJson(invitationJson.data()));
    }

    final List<FriendInvitationLoaded> result = [];

    for (final FriendInvitation dbInvitation in dbInvitations) {
      final User? user = await userService.getUser(uid: dbInvitation.from);
      if (user != null) {
        result.add(FriendInvitationLoaded(
          from: dbInvitation.from,
          to: dbInvitation.to,
          toUser: user,
        ));
      }
    }

    return result;
  }

  Future<void> acceptFriendInvitation({required String uid}) async {
    deleteInvitation(uid: uid);
    userService.currentUser?.friends.add(uid);
    await userService.saveCurrentUser();

    final User? otherUser = await userService.getUser(uid: uid);
    final QuerySnapshot<Map<String, dynamic>> userResult =
        await db.collection("users").where("uid", isEqualTo: uid).get();
    otherUser?.friends.add(userService.currentUser!.uid);
    userResult.docs.first.reference.set(otherUser!.toJson());
  }

  void declineFriendInvitation({required String uid}) {
    deleteInvitation(uid: uid);
  }

  Future<void> deleteInvitation({required String uid}) async {
    final QuerySnapshot<Map<String, dynamic>> invitations = await db
        .collection("friend_invitations")
        .where("to", isEqualTo: userService.currentUser?.uid)
        .where("from", isEqualTo: uid)
        .get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> document
        in invitations.docs) {
      await db.doc(document.reference.path).delete();
    }
  }

  Future<List<User>> loadFriends() async {
    final List<String> friendUids = userService.currentUser!.friends;
    final QuerySnapshot<Map<String, dynamic>> dbFriends =
        await db.collection("users").where("uid", whereIn: friendUids).get();

    return dbFriends.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> dbFriend) =>
            User.fromJson(dbFriend.data()))
        .toList();
  }
}
