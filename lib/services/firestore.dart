import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String note, String title) {
    return notes.add({
      'title': title,
      'note': note,
      'timeStamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timeStamp', descending: true).snapshots();
    return notesStream;
  }

  Future<void> updateNote(String docID, String newNote, String newTitle) {
    return notes.doc(docID).update(
        {'note': newNote, 'title': newTitle, 'timeStamp': Timestamp.now()});
  }

  Future<void> deleteNote(
    String docID,
  ) {
    return notes.doc(docID).delete();
  }
}
