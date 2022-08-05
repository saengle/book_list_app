import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteBookViewModel {
  final _db = FirebaseFirestore.instance;

  Future deleteBook({
    required DocumentSnapshot document,
  }) async {
    await _db.collection('books').doc(document.id).delete();
  }

}
