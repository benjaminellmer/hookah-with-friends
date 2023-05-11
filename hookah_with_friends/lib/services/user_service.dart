import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../exceptions/datastore_exception.dart";
import "../model/user.dart" as model;

class UserService {
  model.User? currentUser;
  DocumentReference<dynamic>? _currentUserRef;

  Future<DocumentReference<Object?>> get currentUserRef async {
    if (_currentUserRef == null) {
      final QuerySnapshot<Map<String, dynamic>> users = await FirebaseFirestore
          .instance
          .collection("users")
          .where("uid", isEqualTo: currentUser!.uid)
          .get();

      return users.docs.first.reference;
    } else {
      return _currentUserRef!;
    }
  }

  void resetCurrentUser() {
    currentUser = null;
    _currentUserRef = null;
  }

  Future<void> saveCurrentUser() async {
    (await currentUserRef).set(currentUser!.toJson());
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
    String? userName,
  }) async {
    final User? authUser = FirebaseAuth.instance.currentUser;

    if (authUser != null && authUser.email != null) {
      final String email = FirebaseAuth.instance.currentUser!.email!;

      currentUser = await getUser(uid: authUser.uid);
      currentUser ??= await createUser(
        uid: authUser.uid,
        userName: userName ?? generateRandomUserName(email),
        email: email,
      );

      return currentUser!;
    } else {
      throw DataStoreException("The user is not logged in!");
    }
  }

  Future<String?> getUidForUserName({required String userName}) async {
    final QuerySnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection("users")
        .where("userName", isEqualTo: userName)
        .get();

    if (user.docs.isEmpty) {
      return null;
    }

    return model.User.fromJson(user.docs.first.data()).uid;
  }

  String generateRandomUserName(String email) {
    final String emailPrefix = email.split("@")[0];
    return "hookah-$emailPrefix";
  }
}
