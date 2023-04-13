import "package:flutter/cupertino.dart";
import "package:google_fonts/google_fonts.dart";
import '../../util/colors.dart';

class HeadingTextXL extends Text {
  HeadingTextXL(super.data, {super.key})
      : super(
          style: TextStyle(
            fontFamily: GoogleFonts.pacifico().fontFamily,
            color: HWFColors.heading.withOpacity(1),
            fontSize: 36,
          ),
        );
}
