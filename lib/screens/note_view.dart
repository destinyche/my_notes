import 'package:flutter/material.dart';
import 'package:my_notes/screens/edit_notes.dart';
import 'package:my_notes/services/firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NoteView extends StatelessWidget {
  NoteView({
    Key? key,
    required this.noteText,
    required this.noteTitleText,
    required this.docID,
  }) : super(key: key);

  final String noteText;
  final String noteTitleText;
  final String docID;

  Future<void> _shareNote() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/note.txt';
    final file = File(path);
    await file.writeAsString(noteText);

    Share.shareXFiles([XFile(path)], text: 'Here is your note');
  }

  final FireStoreServices fireStoreServices = FireStoreServices();

  void openNoteBox(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditNotes(
                  docID: docID,
                  initialText: noteText,
                  initialTitle: noteTitleText,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareNote,
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
            child: Text(
              'Edit',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () => openNoteBox(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment(-1, -1),
                child: Text(
                  noteTitleText,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Color.fromARGB(255, 78, 76, 76),
                height: 2.0,
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment(-1, -1),
                child: Text(
                  noteText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
