import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../bloc/session/sessions_bloc.dart";
import "../../model/session.dart";
import "../../screens/active_session_screen.dart";
import "../../util/formatters/duration_formatters.dart";
import "../indicators/availability_indicator.dart";
import "../indicators/session_progress_indicator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class ActiveSessionCard extends StatefulWidget {
  const ActiveSessionCard(this.session, {super.key});

  final SessionLoaded session;

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
      onTap: () {
        context.read<SessionsBloc>().add(SessionsRefreshInitialized());
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext contextWithoutBloc) =>
                BlocProvider<SessionsBloc>.value(
              value: context.read<SessionsBloc>(),
              child: ActiveSessionScreen(session: widget.session),
            ),
          ),
        );
      },
      child: InkWell(
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PrimaryText("Host: ${widget.session.host.userName}"),
                  Row(
                    children: <Widget>[
                      PrimaryText(widget.session.currentTobacco.name),
                      const SizedBox(width: 8),
                      AvailabilityIndicator(
                          widget.session.currentTobacco.availability),
                    ],
                  ),
                  PrimaryText(
                      "Participants: ${widget.session.numberOfParticipants}"),
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
                        child: SessionProgressIndicator(
                          value: widget.session.progress,
                        ),
                      ),
                      const SizedBox(height: 10),
                      PrimaryText(
                          DurationFormatters.hms(widget.session.activeTime)),
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
