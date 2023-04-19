import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

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
            friend.name,
            fontSize: 16,
          ),
          const Spacer(),
          IconButton(
            constraints: const BoxConstraints(maxWidth: 20.0, maxHeight: 20.0),
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Image.asset(
              "lib/assets/cross.png",
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              constraints: const BoxConstraints(maxWidth: 20.0, maxHeight: 20.0),
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Image.asset(
                "lib/assets/checkmark.png",
                width: 20,
                height: 20,
              ),
          ),
        ],
      ),
    );
  }
}
