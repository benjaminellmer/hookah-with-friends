import "package:flutter/material.dart";

import "../../enum/invitation_state.dart";
import "../../util/colors.dart";

class InvitationStateIndicator extends StatelessWidget {
  const InvitationStateIndicator({
    super.key,
    required this.invitationState,
    required this.width,
    required this.height,
  });

  final InvitationState invitationState;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    switch (invitationState) {
      case InvitationState.unknown:
        return Image.asset(
          "lib/assets/question_orange.png",
          width: width,
          height: height,
        );
      case InvitationState.accepted:
        return Image.asset(
          "lib/assets/checkmark.png",
          color: HWFColors.green,
          width: width,
          height: height,
        );
      case InvitationState.declined:
        return Image.asset(
          "lib/assets/cross.png",
          color: HWFColors.red,
          width: width,
          height: height,
        );
    }
  }
}
