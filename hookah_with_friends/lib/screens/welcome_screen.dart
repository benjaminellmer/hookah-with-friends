import "package:flutter/material.dart";
import "../components/buttons/primary_button.dart";
import "../components/buttons/secondary_button.dart";
import "../components/texts/welcome_text.dart";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              child: RotationTransition(
                turns: new AlwaysStoppedAnimation(180 / 360),
                child: Image.network(
                  'https://images.unsplash.com/photo-1627499949691-154d1fc004c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                    onPress: () {print('Login');},
                  ),
                  PrimaryButton(
                    text: "Sign up",
                    onPress: () {print('Sign up');},
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
