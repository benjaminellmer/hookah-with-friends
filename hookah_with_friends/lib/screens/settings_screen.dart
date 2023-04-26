import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";


import "../components/appbars/back_and_title_app_bar.dart";
import "../components/cards/profile_info_card.dart";
import "change_password_screen.dart";
import "change_username_screen.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Settings"),
        body: Padding(
        padding: const EdgeInsets.all(20),
    child: Column(
        children: const <Widget>[
          ProfileInfoCard(
            info: "Change Username",
            route: ChangeUsernameScreen(),
          ),
          ProfileInfoCard(
            info: "Change Password",
            route: ChangePasswordScreen(),
          ),
        ],
    )
        ),
    );
  }
}