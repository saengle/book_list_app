import 'package:cloud_firestore/cloud_firestore.dart';

class BookListViewModel {
  final _db = FirebaseFirestore.instance;

  // db에 있는 모든 애들을 가져와서 stream으로 내보냄
  Stream<QuerySnapshot> get booksStream => _db.collection('books').snapshots();
}
