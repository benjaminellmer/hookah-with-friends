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

      await userService.setOrCreateCurrentUser(email: email);
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

      await userService.setOrCreateCurrentUser(email: email);
    } on FirebaseAuthException catch (ex) {
      _handleAuthError(ex);
    }
  }

  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    await userService.setOrCreateCurrentUser(
        email: FirebaseAuth.instance.currentUser!.email!);
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
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
