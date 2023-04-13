import "package:flutter/cupertino.dart";

import "../../model/friend.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class InviteCard extends StatelessWidget {
  const InviteCard({super.key, required this.friend});

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Row(
        children: <Widget>[
          PrimaryText(
            "${friend.name} ${friend.code}",
            fontSize: 16,
          ),
          const Spacer(),
          Image.asset(
            "lib/assets/cross.png",
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 20,
          ),
          Image.asset(
            "lib/assets/checkmark.png",
            width: 25,
            height: 25,
          ),
        ],
      ),
    );
  }
}
