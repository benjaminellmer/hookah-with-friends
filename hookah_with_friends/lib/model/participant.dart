import "../enum/invitation_state.dart";

class Participant {
  Participant(
    this.userName, {
    this.invitationState = InvitationState.unknown,
    this.isHost = false,
  });

  final String userName;
  final InvitationState invitationState;
  final bool isHost;
}
