import "package:hookah_with_friends/model/session.dart";

import "../enum/invitation_state.dart";
import "../util/json_utils.dart";

class SessionInvite {
  SessionInvite({
    required this.sessionId,
    this.invitationState = InvitationState.unknown,
  });

  factory SessionInvite.fromJson(Map<String, dynamic> json) {
    return SessionInvite(
      sessionId: json["sessionId"] as String,
      invitationState:
          InvitationState.fromJson(json["invitationState"] as String),
    );
  }

  final String sessionId;
  final InvitationState invitationState;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "sessionId": sessionId,
        "invitationState": invitationState.name,
      };

  static List<SessionInvite> decodeList(dynamic json) {
    return JsonUtils.decodeList<SessionInvite>(
      json as List<dynamic>,
      fromJson: (Map<String, dynamic> invite) => SessionInvite.fromJson(invite),
    );
  }

  static dynamic encodeList(List<SessionInvite> invitations) {
    return JsonUtils.encodeList<SessionInvite>(
      invitations,
      toJson: (SessionInvite invite) => invite.toJson(),
    );
  }
}

class SessionInviteLoaded extends SessionInvite {
  SessionInviteLoaded({
    required this.session,
    required super.sessionId,
    super.invitationState,
  });

  final Session session;
}
