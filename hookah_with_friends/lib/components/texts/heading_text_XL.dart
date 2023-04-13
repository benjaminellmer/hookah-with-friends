import "package:flutter/cupertino.dart";
import "package:google_fonts/google_fonts.dart";
import '../../util/colors.dart';

class HeadingText extends Text {
  HeadingText(super.data, {super.key})
      : super(
          style: TextStyle(
            fontFamily: GoogleFonts.pacifico().fontFamily,
            color: HWFColors.heading,
            fontSize: 36,
          ),
        );
}
