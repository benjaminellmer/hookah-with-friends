import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

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

  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          "472408446626-gojo53ng50ln6upa18ruh6fbiscm0699.apps.googleusercontent.com",
    );
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (ex) {
      _handleAuthError(ex);
    }
  }

  void _handleAuthError(FirebaseAuthException ex) {
    if (ex.code == "invalid-email") {
      throw AuthException("This is no valid email!");
    } else if (ex.code == "user-not-found") {
      throw AuthException("No user with this email exists!");
    } else if (ex.code == "wrong-password") {
      throw AuthException("Wrong password for user!");
    } else {
      throw AuthException("Unknown error occurred!");
    }
  }
}
