import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";


import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/textinputs/primary_text_input.dart";

class ChangeUsernameScreen extends StatelessWidget {
  const ChangeUsernameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Change Username"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const PrimaryTextInput(label: "Change Username: "),
            const SizedBox(height: 20),
            PrimaryButton(
                text: "Save Changes",
                onPress: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}