import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/cards/invite_card.dart";
import "../model/datamodel.dart";
import "../util/testdata/testdata.dart";

class InvitesScreen extends StatelessWidget {
  const InvitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Friend Invites"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              for (User friend in TestData.inviteList) ...<InviteCard>[
                InviteCard(friend: friend)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
