import "../enum/invitation_state.dart";
import "coal_timer.dart";
import "participant.dart";
import "tobacco.dart";

// NOT THE FINAL MODEL!!! We will add more fields later. and the participants will become an own model
class Session {
  Session({
    required this.tobacco,
    required this.participants,
    required this.startTime,
    required this.endTime,
    this.invitationState = InvitationState.unknown,
    this.tobaccoCount = 0,
  }) {
    participants.sort((Participant a, Participant b) {
      if (a.isHost) {
        return 1;
      }
      return a.userName.compareTo(b.userName);
    });
  }

  final Tobacco tobacco;
  final List<Participant> participants;
  final DateTime startTime;
  final DateTime endTime;
  final InvitationState invitationState;
  int tobaccoCount;
  CoalTimer? coalTimer;

  Participant get host {
    return participants
        .firstWhere((Participant participant) => participant.isHost);
  }

  double get progress {
    final DateTime now = DateTime.now();
    if (now.isBefore(startTime)) {
      return 0;
    }
    if (now.isAfter(endTime)) {
      return 1;
    } else {
      final Duration duration = endTime.difference(startTime);
      final Duration elapsed = now.difference(startTime);
      return elapsed.inMilliseconds / duration.inMilliseconds;
    }
  }

  Duration get timeLeft {
    final DateTime now = DateTime.now();
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return endTime.difference(now);
    } else {
      return Duration.zero;
    }
  }

  Duration get totalDuration {
    return endTime.difference(startTime);
  }

  int get numberOfParticipants {
    int result =
        1; // 1 because the host is also an participant -> depends on if we add the host to the participants list
    for (final Participant participant in participants) {
      if (participant.invitationState == InvitationState.accepted) {
        result++;
      }
    }
    return result;
  }
}
