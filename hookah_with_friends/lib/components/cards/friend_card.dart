import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../model/friend.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class FriendCard extends StatelessWidget {
  const FriendCard({super.key, required this.friend, this.trailingIcon});

  final Friend friend;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Row(
        children: [
          Expanded(
            child: PrimaryText(
              friend.name,
              fontSize: 16,
            ),
          ),
          if (trailingIcon != null) trailingIcon!,
        ],
      ),
    );
  }
}

