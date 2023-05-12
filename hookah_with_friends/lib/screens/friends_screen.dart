import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/friends/friends_cubit.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/friend_card.dart";
import "../components/dialogs/delete_friend.dart";
import "../model/user.dart";
import "../util/colors.dart";
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
    return BlocProvider<FriendsCubit>(
      create: (BuildContext context) => FriendsCubit()..loadFriends(),
      child: Scaffold(
        appBar: BackAndTitleAppBar(
          title: "Friends",
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  showDelete = !showDelete;
                });
              },
              icon:
                  showDelete ? const Icon(Icons.close) : const Icon(Icons.edit),
              color: HWFColors.heading,
            ),
          ],
        ),
        body: Builder(builder: (BuildContext context) {
          return BlocBuilder<FriendsCubit, FriendsState>(
            builder: (BuildContext context, FriendsState state) {
              if (state is FriendsLoadSuccess && state.friends.isEmpty) {
                return const Center(
                  child: Text("You currently have no friends!"),
                );
              } else if (state is FriendsLoadSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                          children: <Widget>[
                            for (User friend in state.friends) ...<FriendCard>[
                              FriendCard(
                                friend: friend,
                                trailingIcon: showDelete
                                    ? IconButton(
                                        constraints: const BoxConstraints(
                                            maxHeight: 20.0, maxWidth: 20.0),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return DeleteFriendDialog(
                                                  friend: friend.userName,
                                                  onConfirm: () {});
                                            },
                                          );
                                        },
                                        icon: Image.asset(
                                            "lib/assets/cross.png",
                                            width: 20,
                                            height: 20),
                                      )
                                    : null,
                              )
                            ]
                          ],
                        )),
                      ),
                      const SizedBox(height: 16.0),
                      PrimaryButton(
                        text: "Add Friend",
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                  builder: (BuildContext context) =>
                                      AddFriendScreen()));
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is FriendsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Center(
                    child: PrimaryButton(
                  text: "Retry",
                  onPress: () {
                    context.read<FriendsCubit>().loadFriends();
                  },
                ));
              }
            },
          );
        }),
      ),
    );
  }
}
