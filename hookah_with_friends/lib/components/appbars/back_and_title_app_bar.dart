import "package:flutter/material.dart";

import '../../util/colors.dart';
import '../texts/heading_text.dart';

class BackAndTitleAppBar extends AppBar {
  BackAndTitleAppBar({super.key, super.actions, required final String title})
      : super(
          centerTitle: true,
          title: HeadingText(title),
          backgroundColor: HWFColors.appBar,
          iconTheme: IconThemeData(
            color: HWFColors.heading,
          ),
        );
}
