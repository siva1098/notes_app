import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:notes_app/models/notes.dart';
import 'dart:math' as math;

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  late final Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('notesBox');
  }

  _addNote() {
    Notes note = Notes(title: titleController.text, body: bodyController.text);
    note.color = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    box.add(note);
    // print('Info added to box!');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              autofocus: true,
              controller: titleController,
              style: GoogleFonts.openSans(
                  fontSize: 20.0, fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: bodyController,
              style: GoogleFonts.openSans(
                  fontSize: 20.0, fontWeight: FontWeight.w500),
              decoration: const InputDecoration(border: OutlineInputBorder()),
              maxLines: 10,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () => _addNote(),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
