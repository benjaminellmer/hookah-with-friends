import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/coaltimer/coal_timer_bloc.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/tobacco_card.dart";
import "../components/texts/heading_text.dart";
import "../components/texts/primary_text.dart";
import "../components/texts/subheading.dart";
import "../model/session.dart";
import "../util/colors.dart";

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                child: RotationTransition(
                turns: new AlwaysStoppedAnimation(180/360),
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
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                Container(
                  alignment: Alignment.centerLeft,
                  child: HeadingText("Welcome \nBack!"),
                ),
                const SizedBox(height: 32),
                TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      prefixIcon: Icon(
                        Icons.person,
                        color: HWFColors.flavour,
                      ),
                      filled: true,
                      fillColor: HWFColors.cardBackground,
                      labelText: "Username",
                      hintText: 'KopfalNorbert',
                      labelStyle: TextStyle(color: HWFColors.flavour),
                    ),
                ),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      prefixIcon: Icon(
                        Icons.lock_open,
                        color: HWFColors.flavour,
                      ),
                      filled: true,
                      fillColor: HWFColors.cardBackground,
                      labelText: "Password",
                      hintText: 'Password',
                      labelStyle: TextStyle(color: HWFColors.flavour),
                    ),
                    validator: (value) {
                      if (value!.isEmpty && value!.length < 5) {
                        return 'Enter a valid password';
                        {
                          return null;
                        }
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Forgot password?',
                        style: TextStyle(
                            color: HWFColors.flavour,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                PrimaryButton(
                  text: "Log in",
                  onPress: () {},
                ),
                SubHeading("or"),
                PrimaryButton(
                  text: "Sign up",
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