import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/add_friend/add_friend_cubit.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/dialogs/error_add_friend_dialog.dart";
import "../components/textinputs/primary_text_input.dart";

class AddFriendScreen extends StatelessWidget {
  AddFriendScreen({super.key});

  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddFriendCubit>(
      create: (BuildContext context) => AddFriendCubit(),
      child: Scaffold(
        appBar: BackAndTitleAppBar(
          title: "Add Friend",
        ),
        body: Builder(builder: (BuildContext context) {
          return BlocListener<AddFriendCubit, AddFriendState>(
            listener: (BuildContext context, AddFriendState state) {
              if (state is AddFriendError) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      ErrorAddFriendDialog(message: state.message),
                );
              }
              if (state is AddFriendSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invitation was sent!")));
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  PrimaryTextInput(
                      label: "Username: ", controller: userNameController),
                  const SizedBox(height: 32),
                  PrimaryButton(
                      text: "Send invitation",
                      onPress: () {
                        context
                            .read<AddFriendCubit>()
                            .addFriend(userName: userNameController.text);
                      })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
