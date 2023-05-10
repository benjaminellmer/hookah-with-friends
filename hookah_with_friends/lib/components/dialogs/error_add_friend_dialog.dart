import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "../../util/colors.dart";
import "../buttons/primary_button.dart";

class ErrorAddFriendDialog extends StatelessWidget {
  const ErrorAddFriendDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HWFColors.cardBackground.withOpacity(1.0),
      titleTextStyle: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontSize: 20,
      ),
      title: const Center(child: Text("Error")),
      content: Text(message),
      actions: <Widget>[
        PrimaryButton(
          text: "Ok",
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
