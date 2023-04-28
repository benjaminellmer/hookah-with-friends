class User {
  User({
    required this.userName,
    required this.uid,
    required this.email,
    required this.motto,
  });

  final String uid;
  final String userName;
  final String email;
  final String motto;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "uid": uid,
        "userName": userName,
        "email": email,
        "motto": motto,
      };

  List<String> get friends {
    return [""];
  }
}
