import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/auth/auth_bloc.dart";
import "../components/buttons/primary_button.dart";
import "../components/buttons/secondary_button.dart";
import "../components/indicators/auth_loading_indicator.dart";
import "../components/textinputs/password_input.dart";
import "../components/textinputs/username_input.dart";
import "../components/texts/divider_text.dart";
import "../components/texts/heading_text_XL.dart";
import "login_screen.dart";

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthAuthenticated) {
          Navigator.popUntil(context, (Route route) => route.isFirst);
        }
        if (state is AuthUnauthenticated) {
          if (state.statusMessage != null) {
            final SnackBar snackBar = SnackBar(
              content: Center(
                child: Text(state.statusMessage!),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: Image.asset('lib/assets/smoke_white.png'),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(8),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.30),
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
                    const SizedBox(height: 36),
                    PrimaryButton(
                      text: "Sign up",
                      onPress: () {
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                  username: usernameController.text,
                                  email: emailController.text,
                                  password: passwordController.text),
                            );
                      },
                    ),
                    const DividerText("or"),
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
                  ],
                ),
              ),
              const AuthLoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
