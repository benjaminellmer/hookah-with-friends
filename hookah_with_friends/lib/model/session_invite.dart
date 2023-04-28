import "../enum/invitation_state.dart";
import "session.dart";
import "user.dart";

class SessionInvite {
  SessionInvite({
    required this.user,
    required this.invitationState,
    required this.session,
  });

  final User user;
  final Session session;
  final InvitationState invitationState;
}
