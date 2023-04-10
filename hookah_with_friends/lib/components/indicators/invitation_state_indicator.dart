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

  String get assetPath {
    switch (invitationState) {
      case InvitationState.unknown:
        return "lib/assets/question_orange.png";
      case InvitationState.accepted:
        return "lib/assets/checkmark.png";
      case InvitationState.declined:
        return "lib/assets/cross.png";
    }
  }

  Color get color {
    switch (invitationState) {
      case InvitationState.unknown:
        return HWFColors.orange;
      case InvitationState.accepted:
        return HWFColors.green;
      case InvitationState.declined:
        return HWFColors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      color: color,
      width: width,
      height: height,
    );
  }
}
