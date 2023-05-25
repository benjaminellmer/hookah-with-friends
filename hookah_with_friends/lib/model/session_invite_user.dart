import "../enum/invitation_state.dart";
import "../util/json_utils.dart";

class SessionInviteUser {
  SessionInviteUser({
    required this.userId,
    this.invitationState = InvitationState.unknown,
  });

  factory SessionInviteUser.fromJson(Map<String, dynamic> json) {
    return SessionInviteUser(
      userId: json["userId"] as String,
      invitationState:
          InvitationState.fromJson(json["invitationState"] as String),
    );
  }

  final String userId;
  InvitationState invitationState;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "userId": userId,
        "invitationState": invitationState.name,
      };

  static List<SessionInviteUser> decodeList(dynamic json) {
    return JsonUtils.decodeList<SessionInviteUser>(
      json as List<dynamic>,
      fromJson: (Map<String, dynamic> invite) =>
          SessionInviteUser.fromJson(invite),
    );
  }

  static dynamic encodeList(List<SessionInviteUser> invitations) {
    return JsonUtils.encodeList<SessionInviteUser>(
      invitations,
      toJson: (SessionInviteUser invite) => invite.toJson(),
    );
  }
}
