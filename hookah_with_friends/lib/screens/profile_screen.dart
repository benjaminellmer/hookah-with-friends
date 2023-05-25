import "package:flutter/material.dart";

import "../components/cards/profile_info_card.dart";
import "../components/cards/user_card.dart";
import "../services/user_service.dart";
import "../util/locator.dart";
import "friends_screen.dart";
import "invites_screen.dart";

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
                const SizedBox(height: 30),
                ProfileInfoCard(
                  info:
                      "Friends (${getIt.get<UserService>().currentUser?.friends.length})",
                  route: const FriendsScreen(),
                ),
                const ProfileInfoCard(
                  info: "Invites",
                  route: InvitesScreen(),
                ),
                // const ProfileInfoCard(
                //   info: "Sessions",
                //   route: HistoryScreen(),
                // ),
                // const ProfileInfoCard(
                //   info: "Settings",
                //   route: SettingsScreen(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
