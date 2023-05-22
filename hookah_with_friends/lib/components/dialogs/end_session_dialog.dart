import "package:flutter/material.dart";

import "../../util/colors.dart";

void showEndSessionDialog(BuildContext context, VoidCallback onAccept) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EndSessionDialog(onAccept: onAccept);
    },
  );
}

class EndSessionDialog extends StatelessWidget {
  const EndSessionDialog({super.key, required this.onAccept});

  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HWFColors.cardBackground.withOpacity(1),
      content:
          const Text("Are you sure that you want to end the current session ?"),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            onAccept();
            Navigator.popUntil(
                context, (Route<dynamic> route) => route.isFirst);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: HWFColors.button,
          ),
          child: const Text("End Session"),
        ),
      ],
    );
  }
}
