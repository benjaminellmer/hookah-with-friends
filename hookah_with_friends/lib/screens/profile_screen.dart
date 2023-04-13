import "package:flutter/material.dart";

import "../components/cards/profile_info_card.dart";
import "../components/cards/user_card.dart";
import "../util/testdata/testdata.dart";

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
                  ),
                  ProfileInfoCard(
                      info: "Invites: ${TestData.testuser.invites}",
                  ),
                  ProfileInfoCard(
                    info: "Sessions: ${TestData.testuser.sessions}",
                  ),
                  const ProfileInfoCard(
                    info: "Settings",
                  ),
                ],
              ),
          ),
        ),
      ),

    );
  }
}
