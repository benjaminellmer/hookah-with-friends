import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../util/colors.dart";
import "../cards/small_card.dart";
import "../texts/primary_text.dart";

class TimePickerCard extends StatelessWidget {
  const TimePickerCard(
      {super.key,
      required this.initialDateTime,
      required this.dateTimeChanged});

  final DateTime initialDateTime;
  final Function(DateTime) dateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      child: Row(
        children: <Widget>[
          PrimaryText("Time: "),
          const Spacer(),
          PrimaryText(DateFormat.Hm().format(initialDateTime)),
          IconButton(
            onPressed: () async {
              final TimeOfDay? newSelectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(initialDateTime),
              );

              if (newSelectedTime != null) {
                dateTimeChanged(DateTime(
                  initialDateTime.year,
                  initialDateTime.month,
                  initialDateTime.day,
                  newSelectedTime.hour,
                  newSelectedTime.minute,
                ));
              }
            },
            icon: Icon(
              Icons.watch_later_outlined,
              color: HWFColors.text,
            ),
          )
        ],
      ),
    );
  }
}
