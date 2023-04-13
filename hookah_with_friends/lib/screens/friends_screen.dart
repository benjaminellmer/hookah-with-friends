import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/cards/friend_card.dart";
import "../model/friend.dart";
import "../util/testdata/testdata.dart";

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Friends"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              for (Friend friend in TestData.friendList) ...<FriendCard>[
                FriendCard(friend: friend)
              ]
            ],
          ),
        ),
      ),
    );
  }

}