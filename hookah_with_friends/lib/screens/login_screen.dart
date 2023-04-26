import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/auth/auth_bloc.dart";
import "../components/buttons/primary_button.dart";
import "../components/buttons/secondary_button.dart";
import "../components/dialogs/forgot_password_dialog.dart";
import "../components/indicators/auth_loading_indicator.dart";
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pop();
        }
        if (state is AuthUnauthenticated) {
          if (state.errorMessage != null) {
            final SnackBar snackBar = SnackBar(
              content: Center(
                child: Text(state.errorMessage!),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.22),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: HeadingTextXL("Welcome \nBack!"),
                    ),
                    const SizedBox(height: 32),
                    UsernameInput(
                        labelText: "E-mail",
                        hintText: "KopfalNorberts@hooker.com",
                        icon: Icons.person,
                        controller: usernameController),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: PasswordInput(
                          labelText: "Password",
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
                              return const ForgotPasswordDialog(
                                  title: "Reset Password",
                                  description: "Send email to reset password?");
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
                        // Navigator.popUntil(context, (route) => route.isFirst);
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                email: usernameController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                    ),
                    const DividerText("or"),
                    SecondaryButton(
                      text: "Sign up",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  SignupScreen()),
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
