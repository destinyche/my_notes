import 'package:flutter/material.dart';

import 'package:my_notes/services/firestore.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({
    super.key,
    this.docID,
    this.initialText,
    this.initialTitle,
  });

  final String? docID;
  final String? initialTitle;
  final String? initialText;

  @override
  // ignore: library_private_types_in_public_api
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final FireStoreServices fireStoreServices = FireStoreServices();

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      textController.text = widget.initialText!;
    }
    if (widget.initialTitle != null) {
      titleController.text = widget.initialTitle!;
    }
  }

  void saveNote() {
    if (widget.docID == null) {
      fireStoreServices.addNote(textController.text, titleController.text);
    } else {
      fireStoreServices.updateNote(
          widget.docID!, textController.text, titleController.text);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              minLines: null,
              expands: false,
              decoration: const InputDecoration(
                hintText: 'Title...',
              ),
            ),
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
      ),
    );
  }
}
