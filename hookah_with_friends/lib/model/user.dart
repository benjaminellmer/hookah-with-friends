import "../util/json_utils.dart";

class User {
  User({
    required this.userName,
    required this.uid,
    required this.email,
    this.friends = const <String>[],
    this.motto,
  });

  final String uid;
  final String userName;
  final String email;
  final String? motto;
  List<String> friends;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json["uid"] as String,
      userName: json["userName"] as String,
      email: json["email"] as String,
      motto: json["motto"] as String?,
      friends: JsonUtils.decodeList(json["friends"]),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "uid": uid,
        "userName": userName,
        "email": email,
        "motto": motto,
        "friends": friends
      };
}
