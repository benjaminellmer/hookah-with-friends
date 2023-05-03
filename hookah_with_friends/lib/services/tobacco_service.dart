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

  Future<List<Tobacco>> getTobaccosForUser() async {
    final List<Tobacco> tobaccos = <Tobacco>[];

    final String? currentUid = userService.getCurrentUid();
    final QuerySnapshot<Map<String, dynamic>> allTobaccos = await db
        .collection("tobaccos")
        .where("uid", isEqualTo: currentUid)
        .get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in allTobaccos.docs) {
      tobaccos.add(Tobacco.fromJson(doc.data()));
    }

    return tobaccos;
  }
}
