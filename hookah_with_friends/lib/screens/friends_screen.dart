import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/friend_card.dart";
import "../model/friend.dart";
import "../util/colors.dart";
import "../util/testdata/testdata.dart";

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(
        title: "Friends",
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Icons.edit),
            color: HWFColors.heading,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10),
            Expanded (
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (Friend friend in TestData.friendList) ...<FriendCard>[
                      FriendCard(friend: friend)
                    ]
                  ],
                )
              ),
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              text: "Add Friend",
              onPress: () {

              },
            ),
          ],
        ),
      ),
    );
  }

}