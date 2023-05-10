import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hookah_with_friends/screens/signup_screen.dart";

import "../bloc/auth/auth_bloc.dart";
import "../components/buttons/google_button.dart";
import "../components/buttons/primary_button.dart";
import "../components/buttons/secondary_button.dart";
import "../components/texts/welcome_text.dart";
import "login_screen.dart";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
                child: Image.asset(
              'lib/assets/smoke_white.gif',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            )),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: WelcomeText("Hookah \nwith \nfriends"),
                  ),
                  const SizedBox(height: 64),
                  SecondaryButton(
                    text: "Log in",
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                            builder: (BuildContext context) => LoginScreen()),
                      );
                    },
                  ),
                  GoogleButton(onPress: () {
                    context.read<AuthBloc>().add(AuthGoogleLogin());
                  }),
                  PrimaryButton(
                    text: "Sign up",
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                            builder: (BuildContext context) => SignupScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
