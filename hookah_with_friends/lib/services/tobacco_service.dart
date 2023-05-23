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
    final String? currentUid = userService.currentUser?.uid;
    if (currentUid != null) {
      return db
          .collection("tobaccos")
          .add(tobacco.toJson().withUid(currentUid));
    } else {
      throw DataStoreException("The user is not logged in!");
    }
  }

  Future<List<TobaccoLoaded>> getTobaccosForUser() async {
    final List<TobaccoLoaded> tobaccos = <TobaccoLoaded>[];

    final String? currentUid = userService.currentUser?.uid;
    final QuerySnapshot<Map<String, dynamic>> allTobaccos = await db
        .collection("users")
        .where("uid", isEqualTo: currentUid)
        .get()
        .then((querySnapshot) {
          final String id = querySnapshot.docs.first.id;

           return db.collection("users")
              .doc(id)
              .collection("tobaccos")
              .get();
        });

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in allTobaccos.docs) {
      tobaccos.add(TobaccoLoaded(
          tobacco: Tobacco.fromJson(doc.data()), documentId: doc.id));
    }

    return tobaccos;
  }

  Future<List<TobaccoLoaded>> getNewTobaccos() async {
    final List<TobaccoLoaded> tobaccos = <TobaccoLoaded>[];

    final QuerySnapshot<Map<String, dynamic>> allTobaccos = await db
        .collection("tobaccos_predefined")
        .get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in allTobaccos.docs) {
      tobaccos.add(TobaccoLoaded(
          tobacco: Tobacco.fromJson(doc.data()), documentId: doc.id));
    }

    return tobaccos;
  }

  Future<void> deleteTobacco({required TobaccoLoaded tobacco}) async {
    await db.collection("tobaccos").doc(tobacco.documentId).delete();
  }
}
