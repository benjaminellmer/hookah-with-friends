import "package:flutter/material.dart";

import "../util/colors.dart";

class SessionProgressIndicator extends CircularProgressIndicator {
  SessionProgressIndicator({super.key, super.value})
      : super(
          strokeWidth: 8,
          backgroundColor: const Color(0xff2f2f3d),
          color: HWFColors.text,
        );
}
