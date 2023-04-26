import "package:firebase_auth/firebase_auth.dart";

import "../exceptions/auth_exception.dart";

class AuthService {
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (ex) {
      _handleAuthError(ex);
    }
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (ex) {
      _handleAuthError(ex);
    }
  }

  void _handleAuthError(FirebaseAuthException ex) {
    throw AuthException(ex.message ?? ex.code);
    if (ex.code == "invalid-email") {
      throw AuthException("No user with this email exists!");
    } else if (ex.code == "wrong-password") {
      throw AuthException("Wrong password for user!");
    } else {
      throw AuthException("Unknown error occurred!");
    }
  }
}
