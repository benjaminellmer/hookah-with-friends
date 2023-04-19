import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../util/colors.dart";

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: HWFColors.heading.withOpacity(1)),
      ),
      content: Text(
        description,
        style: TextStyle(color: HWFColors.text),
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
