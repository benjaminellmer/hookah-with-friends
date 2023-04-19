import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/friend_card.dart";
import "../model/friend.dart";
import "../util/colors.dart";
import "../util/testdata/testdata.dart";
import "add_friend.dart";

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {

  bool showDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(
        title: "Friends",
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showDelete = !showDelete;
              });
            },
            icon: showDelete ? const Icon(Icons.close) : const Icon(Icons.edit),
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
                      FriendCard(
                        friend: friend,
                        trailingIcon: showDelete ?
                            IconButton(
                              constraints: const BoxConstraints(maxHeight: 20.0, maxWidth: 20.0),
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon:  Image.asset(
                                  "lib/assets/cross.png",
                                  width: 20,
                                  height: 20
                              ),
                            )
                            : null,
                      )
                    ]
                  ],
                )
              ),
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              text: "Add Friend",
              onPress: () {
                Navigator.push(
                    context,MaterialPageRoute<Widget>(
                    builder: (BuildContext context) =>
                    const AddFriendScreen())
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}