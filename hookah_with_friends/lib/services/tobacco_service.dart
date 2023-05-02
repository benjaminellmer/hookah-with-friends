import "package:cloud_firestore/cloud_firestore.dart";

import "../exceptions/datastore_exception.dart";
import "../model/tobacco.dart";
import "../util/extensions.dart";
import "../util/locator.dart";
import "user_service.dart";

class TobaccoService {
  final UserService userService = getIt.get<UserService>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentReference<dynamic>?> createTobacco(Tobacco tobacco) async {
    final String? currentUid = userService.getCurrentUid();
    if (currentUid != null) {
      return db
          .collection("tobaccos")
          .add(tobacco.toJson().withUid(currentUid));
    } else {
      throw DataStoreException("The user is not logged in!");
    }
  }
}
