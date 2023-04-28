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

  Map<String, dynamic> toJson() => <String, dynamic>{
        "user": user.toJson(),
        "session": session.toJson(),
        "invitationState": invitationState.name,
      };
}
