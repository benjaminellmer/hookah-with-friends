import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../util/colors.dart";
import "../textinputs/username_input.dart";

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog(
      {super.key, required this.title, required this.description, required this.controller});

  final String title;
  final String description;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: HWFColors.heading.withOpacity(1)),
      ),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Text(
              description,
              style: TextStyle(color: HWFColors.text),
            ),
            SizedBox(height: 24),
            UsernameInput(
                labelText: "Email",
                hintText: "KopfalNorbert69@hotmail.com",
                icon: Icons.email, controller: controller),
          ],
        ),
      ),
      backgroundColor: HWFColors.background,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            "Cancel",
            style: TextStyle(color: HWFColors.heading.withOpacity(1)),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Send'),
          child: Text(
            "Send",
            style: TextStyle(
                color: HWFColors.heading.withOpacity(1),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
