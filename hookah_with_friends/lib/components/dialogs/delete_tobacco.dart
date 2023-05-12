import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

import "../../util/colors.dart";

class DeleteTobaccoDialog extends StatelessWidget {
  const DeleteTobaccoDialog({super.key, required this.tobacco, required this.onConfirm});

  final String tobacco;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HWFColors.cardBackground.withOpacity(1.0),
      titleTextStyle: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontSize: 20,
      ),
      title: Center(
          child: Text("Delete tobacco $tobacco?")
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "lib/assets/cross.png",
            width: 20,
            height: 20,
          ),
        ),
        IconButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          icon: Image.asset(
            "lib/assets/checkmark.png",
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}
