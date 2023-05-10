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
