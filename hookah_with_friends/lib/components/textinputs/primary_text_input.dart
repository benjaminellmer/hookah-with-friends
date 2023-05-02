import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "../../util/colors.dart";
import "../cards/small_card.dart";
import "../texts/primary_text.dart";

class PrimaryTextInput extends StatelessWidget {
  const PrimaryTextInput({super.key, required this.label, this.controller});

  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            PrimaryText(label),
            const Spacer(),
            Flexible(
              flex: 5,
              child: TextField(
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: HWFColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                controller: controller,
                cursorColor: HWFColors.text,
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
