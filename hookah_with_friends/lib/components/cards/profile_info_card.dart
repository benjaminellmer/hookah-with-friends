
import "package:flutter/cupertino.dart";

import "../texts/primary_text.dart";
import "primary_card.dart";

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key, required this.info});

  final String info;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Row(
        children: <Widget>[
          PrimaryText(info, fontSize: 16,),
          const Spacer(),
          PrimaryText(">", fontSize: 20)
        ],
      ),
    );
  }
}
