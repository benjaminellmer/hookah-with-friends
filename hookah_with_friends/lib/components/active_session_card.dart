import "dart:async";

import "package:flutter/material.dart";

import "../model/session.dart";
import "../util/colors.dart";
import "../util/formatters/duration_formatters.dart";
import "availability_indicator.dart";
import "primary_card.dart";
import "primary_text.dart";

class ActiveSessionCard extends StatefulWidget {
  const ActiveSessionCard(this.session, {super.key});

  final Session session;

  @override
  State<ActiveSessionCard> createState() => _ActiveSessionCardState();
}

class _ActiveSessionCardState extends State<ActiveSessionCard> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onTap: () {  },
      child: InkWell(
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrimaryText("Host: ${widget.session.host}"),
                  Row(
                    children: <Widget>[
                      PrimaryText(widget.session.tobacco.name),
                      const SizedBox(width: 8),
                      AvailabilityIndicator(widget.session.tobacco.availability),
                    ],
                  ),
                  PrimaryText("Participants: ${widget.session.participants.length}"),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: SizedBox(
                  width: 70,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          value: widget.session.progress,
                          strokeWidth: 8,
                          backgroundColor: const Color(0xff2f2f3d),
                          color: HWFColors.text,
                        ),
                      ),
                      const SizedBox(height: 10),
                      PrimaryText(DurationFormatters.hms(widget.session.timeLeft)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
