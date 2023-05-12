import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

import "../exceptions/auth_exception.dart";
import "../util/locator.dart";
import "user_service.dart";

class AuthService {
  final UserService userService = getIt.get<UserService>();

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
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (ex) {
      _handleAuthError(ex);
    }
  }

  void _handleAuthError(FirebaseAuthException ex) {
    throw AuthException(ex.message ?? ex.code);
  }
}
