import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import '../../util/colors.dart';

class DividerText extends StatelessWidget {
  const DividerText(this.data, {super.key});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: HWFColors.divider,
            height: 2,
            thickness: 2,
            indent: 10,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: HWFColors.subheading,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Expanded(
          child: Divider(
            color: HWFColors.divider,
            height: 2,
            thickness: 2,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
