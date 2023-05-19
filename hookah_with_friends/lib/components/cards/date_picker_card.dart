import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../util/colors.dart";
import "../texts/primary_text.dart";
import "small_card.dart";

class DatePickerCard extends StatelessWidget {
  const DatePickerCard(
      {super.key,
      required this.initialDateTime,
      required this.dateTimeChanged});

  final DateTime initialDateTime;
  final Function(DateTime) dateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      onTap: () async {
        final DateTime? newSelectedDate = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: initialDateTime,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 2),
          builder: (BuildContext context, Widget? child) => Theme(
            data: ThemeData().copyWith(
                colorScheme: ColorScheme.dark(
                    primary: HWFColors.button,
                    onPrimary: HWFColors.text,
                    surface: HWFColors.background,
                    onSurface: HWFColors.text),
                dialogBackgroundColor:
                    HWFColors.cardBackground.withOpacity(1.0),
                textButtonTheme: TextButtonThemeData(
                    style:
                        TextButton.styleFrom(foregroundColor: HWFColors.text))),
            child: child!,
          ),
        );

        if (newSelectedDate != null) {
          dateTimeChanged(DateTime(
            newSelectedDate.year,
            newSelectedDate.month,
            newSelectedDate.day,
            initialDateTime.hour,
            initialDateTime.minute,
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            PrimaryText("Date: "),
            const Spacer(),
            PrimaryText(DateFormat("E, dd.MM.yyyy").format(initialDateTime)),
            const SizedBox(width: 8.0),
            Icon(Icons.edit_calendar, color: HWFColors.text),
          ],
        ),
      ),
    );
  }
}
