import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/textinputs/primary_text_input.dart";

class AddFriendScreen extends StatelessWidget{
  const AddFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(
        title: "Add Friend",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const <Widget>[
            PrimaryTextInput(label: "Name: "),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

}
