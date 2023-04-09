import "package:flutter/material.dart";

import "../util/colors.dart";
import "heading_text.dart";

class BackAndTitleAppBar extends AppBar {
  BackAndTitleAppBar({super.key, required final String title})
      : super(
          title: HeadingText(title),
          backgroundColor: HWFColors.appBar,
          iconTheme: IconThemeData(
            color: HWFColors.heading,
          ),
        );
}
