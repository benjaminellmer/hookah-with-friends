import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hookah_with_friends/util/colors.dart";

import "../../bloc/auth/auth_bloc.dart";

class SetUsernameDialog extends StatelessWidget {
  SetUsernameDialog({
    super.key,
  });

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Please set a username",
        style: TextStyle(color: HWFColors.heading.withOpacity(1)),
      ),
      content: SizedBox(
        height: 100,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                filled: true,
                fillColor: HWFColors.cardBackground,
                labelText: "Username",
                hintText: "hookahuser",
                labelStyle: TextStyle(color: HWFColors.flavour),
              ),
            )
          ],
        ),
      ),
      backgroundColor: HWFColors.background,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLoggedIn(
                FirebaseAuth.instance.currentUser!,
                userName: controller.text));
          },
          child: Text(
            "Save",
            style: TextStyle(
                color: HWFColors.heading.withOpacity(1),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
