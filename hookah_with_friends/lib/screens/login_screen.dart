import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/auth/auth_bloc.dart";
import "../components/buttons/primary_button.dart";
import "../components/buttons/secondary_button.dart";
import "../components/indicators/auth_loading_indicator.dart";
import "../components/dialogs/forgot_password_dialog.dart";
import "../components/textinputs/password_input.dart";
import "../components/textinputs/username_input.dart";
import "../components/texts/divider_text.dart";
import "../components/texts/heading_text_XL.dart";
import "../util/colors.dart";
import "signup_screen.dart";

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: HeadingTextXL("Welcome \nBack!"),
                  ),
                  const SizedBox(height: 32),
                  UsernameInput(
                      labelText: "Username",
                      hintText: "KopfalNorberts",
                      icon: Icons.person,
                      controller: usernameController),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: PasswordInput(
                        labelText: "Passwords",
                        hintText: "Password",
                        icon: Icons.lock_open,
                        controller: passwordController),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ForgotPasswordDialog(title: "Reset Password", description: "Send email to reset password?");
                          },
                        );
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: HWFColors.heading.withOpacity(1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    text: "Log in",
                    onPress: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      context.read<AuthBloc>().add(AuthLogin());
                    },
                  ),
                  const DividerText("or"),
                  SecondaryButton(
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
