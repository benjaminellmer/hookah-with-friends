
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../texts/primary_text.dart";
import "primary_card.dart";

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key, required this.info, required this.route});

  final String info;
  final Widget route;


  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
              builder: (BuildContext context) =>
                route
          ),
        );
      },
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
