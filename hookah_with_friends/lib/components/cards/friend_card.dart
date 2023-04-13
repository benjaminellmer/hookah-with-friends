import "package:flutter/cupertino.dart";

import "../../model/friend.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class FriendCard extends StatelessWidget {
  const FriendCard({super.key, required this.friend});

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: PrimaryText(
          "${friend.name} ${friend.code}",
          fontSize: 16,
        ),
    );
  }
}
