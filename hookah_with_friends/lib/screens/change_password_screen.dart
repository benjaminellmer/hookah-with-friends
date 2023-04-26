import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";


import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/textinputs/primary_text_input.dart";

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Change Password"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const PrimaryTextInput(label: "Old Password: "),
            const SizedBox(height: 8),
            const PrimaryTextInput(label: "New Password: "),
            const SizedBox(height: 8),
            const PrimaryTextInput(label: "Repeat Password: "),
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