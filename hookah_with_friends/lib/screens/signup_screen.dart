import "package:flutter/material.dart";

import "../components/buttons/primary_button.dart";
import "../components/buttons/secondary_button.dart";
import "../components/textinputs/password_input.dart";
import "../components/textinputs/username_input.dart";
import "../components/texts/divider_text.dart";
import "../components/texts/heading_text_XL.dart";

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            RotationTransition(
              turns: const AlwaysStoppedAnimation<double>(180 / 360),
              child: Image.network(
                "https://images.unsplash.com/photo-1627499949691-154d1fc004c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: HeadingTextXL("Create \nAccount!"),
                  ),
                  const SizedBox(height: 8),
                  UsernameInput(
                      labelText: "Username",
                      hintText: "KopfalNorbert",
                      icon: Icons.person,
                      controller: usernameController),
                  const SizedBox(height: 16),
                  UsernameInput(
                      labelText: "Email",
                      hintText: "KopfalNorbert69@hotmail.com",
                      icon: Icons.email,
                      controller: emailController),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: PasswordInput(
                        labelText: "Passwords",
                        hintText: "Password",
                        icon: Icons.lock_open,
                        controller: passwordController),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: "Sign up",
                    onPress: () {},
                  ),
                  const DividerText("or"),
                  SecondaryButton(
                    text: "Log in",
                    onPress: () {},
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
