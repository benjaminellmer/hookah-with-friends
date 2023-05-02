import "package:firebase_auth/firebase_auth.dart";

class UserService {
  String? getCurrentUid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }
}
