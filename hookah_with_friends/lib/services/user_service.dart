import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../exceptions/datastore_exception.dart";
import "../model/user.dart" as model;

class UserService {
  String? getCurrentUid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<model.User?> getUser({required String uid}) async {
    final QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();

    if (user.docs.isEmpty) {
      return null;
    }

    return model.User.fromJson(user.docs.first.data());
  }

  Future<model.User> createUser({
    required String uid,
    required String userName,
    required String email,
  }) async {
    final model.User user =
        model.User(userName: userName, email: email, uid: uid);

    FirebaseFirestore.instance.collection("users").add(user.toJson());

    return user;
  }

  Future<model.User> setOrCreateCurrentUser({
    required String email,
    String? userName,
  }) async {
    final String? currentUid = getCurrentUid();

    if (currentUid != null) {
      model.User? user = await getUser(uid: currentUid);
      user ??= await createUser(
        uid: currentUid,
        userName: userName ?? userNameByEmail(email),
        email: email,
      );

      return user;
    } else {
      throw DataStoreException("The user is not logged in!");
    }
  }

  String userNameByEmail(String email) {
    return email.split("@")[0];
  }
}
