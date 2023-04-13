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
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: HWFColors.cardBackground.withOpacity(1),
          dayPeriodTextColor: HWFColors.text,
          hourMinuteTextColor: HWFColors.text,
          dialTextColor: HWFColors.text,
          dayPeriodBorderSide: const BorderSide(width: 0),
        ),
      ),
      child: Builder(builder: (BuildContext context) {
        return SmallCard(
          onTap: () async {
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                PrimaryText("Time: "),
                const Spacer(),
                PrimaryText(DateFormat.Hm().format(initialDateTime)),
                const SizedBox(width: 8),
                Icon(
                  Icons.watch_later_outlined,
                  color: HWFColors.text,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
