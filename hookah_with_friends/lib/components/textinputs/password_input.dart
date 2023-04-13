import "package:flutter/material.dart";

import '../../util/colors.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.labelText, required this.hintText, required this.icon, required this.controller});

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          prefixIcon: Icon(
            icon,
            color: HWFColors.flavour,
          ),
          filled: true,
          fillColor: HWFColors.cardBackground,
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(color: HWFColors.flavour),
        ),
        validator: (value) {
          if (value!.isEmpty && value!.length < 5) {
            return 'Enter a valid password';
            {
              return null;
            }
          }
        },
      ),
    );
  }
}
