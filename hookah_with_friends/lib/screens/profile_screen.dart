import "package:flutter/material.dart";

import "../components/cards/profile_info_card.dart";
import "../components/cards/user_card.dart";
import "friends_screen.dart";
import "history_screen.dart";
import "invites_screen.dart";
import "settings_screen.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const <Widget>[
                UserCard(),
                SizedBox(height: 10),
                ProfileInfoCard(
                  info: "Friends: 5",
                  route: FriendsScreen(),
                ),
                ProfileInfoCard(
                  info: "Invites: 5",
                  route: InvitesScreen(),
                ),
                ProfileInfoCard(
                  info: "Sessions: 5",
                  route: HistoryScreen(),
                ),
                ProfileInfoCard(
                  info: "Settings",
                  route: SettingsScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
