import "package:cloud_firestore/cloud_firestore.dart";

import "../model/session.dart";

class SessionService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentReference<dynamic>?> createSession(Session session) async {
    return db.collection("sessions").add(session.toJson());
  }
}
