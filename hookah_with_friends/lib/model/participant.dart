import "../enum/invitation_state.dart";

class Participant {
  Participant(this.userName, {this.invitationState = InvitationState.unknown});

  final String userName;
  final InvitationState invitationState;
}
