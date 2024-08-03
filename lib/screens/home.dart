import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/screens/edit_notes.dart';
import 'package:my_notes/screens/note_view.dart';
import 'package:my_notes/services/firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FireStoreServices fireStoreServices = FireStoreServices();

  void openNoteBox({String? docID}) {
    showDialog(context: context, builder: (context) => EditNotes(docID: docID));
  }

  void noteView(String noteText) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteView(noteText: noteText)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Easy Notes'),
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          child: const Text('Add Note'),
          onPressed: () {
            openNoteBox();
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreServices.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child: LinearProgressIndicator(),
            ));
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading notes"));
          } else {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<DocumentSnapshot> notesList = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // mainAxisSpacing: 1, crossAxisSpacing: 1,
                    crossAxisCount: 2),
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white10,
                      ),
                      child: ListTile(
                        onTap: () => noteView(noteText),
                        title: Stack(
                          children: [
                            Text(
                              noteText,
                              style: const TextStyle(fontSize: 20),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                alignment: const Alignment(1, 1),
                                child: IconButton(
                                  onPressed: () => openNoteBox(docID: docID),
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                alignment: const Alignment(-1, 1),
                                child: IconButton(
                                  onPressed: () =>
                                      fireStoreServices.deleteNote(docID),
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Notes"));
            }
          }
        },
      ),
    );
  }
}
