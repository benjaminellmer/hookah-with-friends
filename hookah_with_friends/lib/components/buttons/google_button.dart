import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../util/colors.dart";

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage("lib/assets/google_logo.png"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: HWFColors.button,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}