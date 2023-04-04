import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "../util/colors.dart";

class PrimaryText extends Text {
  PrimaryText(super.data, {super.key})
      : super(
    style: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: HWFColors.text,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  );
}
