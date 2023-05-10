import "package:hookah_with_friends/model/user.dart";

class FriendInvitation {
  FriendInvitation({required this.from, required this.to});

  factory FriendInvitation.fromJson(Map<String, dynamic> json) {
    return FriendInvitation(
      from: json["from"] as String,
      to: json["to"] as String,
    );
  }

  final String from;
  final String to;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "from": from,
        "to": to,
      };
}

class FriendInvitationLoaded extends FriendInvitation {
  FriendInvitationLoaded(
      {required super.from, required super.to, required this.toUser});

  final User toUser;
}
