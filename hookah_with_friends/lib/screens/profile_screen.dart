import "package:flutter/material.dart";

import "../components/cards/profile_info_card.dart";
import "../components/cards/user_card.dart";
import "../util/testdata/testdata.dart";
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
                children: <Widget>[
                  const UserCard(),
                  const SizedBox(height: 10),
                  ProfileInfoCard(
                    info: "Friends: ${TestData.testuser.friends}",
                    route: const FriendsScreen(),
                  ),
                  ProfileInfoCard(
                    info: "Invites: ${TestData.testuser.invites}",
                    route: const InvitesScreen(),
                  ),
                  ProfileInfoCard(
                    info: "Sessions: ${TestData.testuser.sessions}",
                    route: const HistoryScreen(),
                  ),
                  const ProfileInfoCard(
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
