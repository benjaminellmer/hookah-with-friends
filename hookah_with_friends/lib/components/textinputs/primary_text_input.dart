import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "../../util/colors.dart";
import "../cards/small_card.dart";
import "../texts/primary_text.dart";

class PrimaryTextInput extends StatelessWidget {
  const PrimaryTextInput({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            PrimaryText(label),
            const Spacer(),
            Flexible(
              flex: 5,
              child: TextField(
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: HWFColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                cursorColor: HWFColors.text,
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child: Row(
// children: <Widget>[
// PrimaryText(label),
// const Spacer(),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Builder(builder: (BuildContext contextWithBloc) {
// return Row(
// children: <Widget>[
// BlocBuilder<ElementPickerCubit, ElementPickerSelected>(
// builder: (BuildContext context,
// ElementPickerSelected state) {
// return items[state.selectedIndex].title;
// },
// ),
// const SizedBox(width: 8),
// Icon(
// Icons.expand_more_outlined,
// color: HWFColors.text,
// ),
// ],
// );
// }),
// )
// ],
// ),
// );
