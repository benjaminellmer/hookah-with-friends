import "package:firebase_auth/firebase_auth.dart";

import "../exceptions/auth_exception.dart";

class AuthService {
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        throw AuthException("No user with this email exists!");
      } else if (e.code == "wrong-password") {
        throw AuthException("Wrong password for user!");
      } else {
        throw AuthException("Unknown error occurred!");
      }
    }
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }
}
