extension MapsExtension on Map<String, dynamic> {
  Map<String, dynamic> withUid(String uid) {
    this["uid"] = uid;
    return this;
  }
}
