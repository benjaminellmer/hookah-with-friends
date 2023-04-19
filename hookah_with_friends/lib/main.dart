import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

import "firebase_options.dart";
import "hookah_with_friends_app.dart";
import "util/locator.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HookahWithFriendsApp());
}
