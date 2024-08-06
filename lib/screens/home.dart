import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/screens/edit_notes.dart';
import 'package:my_notes/screens/note_view.dart';
import 'package:my_notes/screens/theme_provider.dart';
// import 'package:my_notes/screens/theme_provider.dart';
import 'package:my_notes/services/firestore.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FireStoreServices fireStoreServices = FireStoreServices();

  void openNoteBox({String? docID, String? initialText, String? initialTitle}) {
    showDialog(
        context: context,
        builder: (context) => EditNotes(
              docID: docID,
              initialText: initialText,
              initialTitle: initialTitle,
            ));
  }

  void noteView(String noteText, String noteTitleText, String docID) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoteView(
                  docID: docID,
                  noteText: noteText,
                  noteTitleText: noteTitleText,
                )));
  }

  void userSignOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.sunny),
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ),
        ],
        centerTitle: true,
        // backgroundColor: Colors.blue,
        title: const Text('Easy Notes'),
      ),
      drawer: Drawer(
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Sign Out',
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            onPressed: () {
              userSignOut();
            },
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          elevation: 0,
          // disabledElevation: 20,
          // backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            'Add Note',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: () {
            openNoteBox();
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreServices.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading notes"));
          } else {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<DocumentSnapshot> notesList = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 100),
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];
                  String noteTitleText = data['title'];

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: ListTile(
                        onTap: () => noteView(noteText, noteTitleText, docID),
                        title: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment(-1, -1),
                                  child: Text(
                                    noteTitleText,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  noteText,
                                  style: const TextStyle(fontSize: 15),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: const Alignment(1.4, 1),
                                child: IconButton(
                                  color: Colors.grey,
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
