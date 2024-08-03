import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NoteView extends StatelessWidget {
  final String noteText;

  const NoteView({
    Key? key,
    required this.noteText,
  }) : super(key: key);

  Future<void> _shareNote() async {
    try {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/note.txt';
      final file = File(path);
      await file.writeAsString(noteText);

      Share.shareXFiles([XFile(path)], text: 'Here is your note');
    } catch (e) {
      print('Error sharing note: $e');
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          noteText,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
