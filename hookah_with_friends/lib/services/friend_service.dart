import "package:cloud_firestore/cloud_firestore.dart";

import "../exceptions/datastore_exception.dart";
import "../model/friend_invitation.dart";
import "../util/locator.dart";
import "user_service.dart";

class FriendService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final UserService userService = getIt.get<UserService>();

  Future<DocumentReference<dynamic>?> createInvitation(
      {required String toUid}) {
    final String? uid = userService.uid;
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
        .where("from", isEqualTo: userService.uid)
        .where("to", isEqualTo: toUid)
        .get();

    return invitations.size != 0;
  }
}
