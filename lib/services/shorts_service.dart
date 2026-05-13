import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/firebase_short_model.dart';

class ShortsService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<FirebaseShortModel>> getShorts() {
    return firestore
        .collection('shorts')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return FirebaseShortModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  Future<void> increaseView(String shortId) async {
    await firestore.collection('shorts').doc(shortId).update({
      'views': FieldValue.increment(1),
    });
  }

  Future<void> increaseLike(String shortId) async {
    await firestore.collection('shorts').doc(shortId).update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> increaseShare(String shortId) async {
    await firestore.collection('shorts').doc(shortId).update({
      'shares': FieldValue.increment(1),
    });
  }
}