class User {
  User({
    required this.userName,
    required this.firebaseId,
    required this.email,
    required this.motto,
  });

  final String firebaseId;
  final String userName;
  final String email;
  final String motto;

  List<String> get friends {
    return [""];
  }
}
