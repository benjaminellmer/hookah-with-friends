import 'package:flutter/material.dart';
import "../util/colors.dart";

class ButtonPrimary extends StatelessWidget {
  String text ;
  VoidCallback onPress;
  ButtonPrimary({ required this.text, required this.onPress });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
          onTap: onPress,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: HWFColors.button,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(text, style: TextStyle(color: Colors.white)),
            ),
          ),
      ),
    );
  }
}