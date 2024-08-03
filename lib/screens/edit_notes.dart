import 'package:flutter/material.dart';

import 'package:my_notes/services/firestore.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({
    super.key,
    this.docID,
  });

  final String? docID;

  @override
  // ignore: library_private_types_in_public_api
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final TextEditingController textController = TextEditingController();
  final FireStoreServices fireStoreServices = FireStoreServices();

  void saveNote() {
    if (widget.docID == null) {
      fireStoreServices.addNote(textController.text);
    } else {
      fireStoreServices.updateNote(
        widget.docID!,
        textController.text,
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docID == null ? 'Add Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveNote,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              maxLines: null,
              minLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: 'Enter your note here...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
