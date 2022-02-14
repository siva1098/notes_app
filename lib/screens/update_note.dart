import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/models/notes.dart';

class UpdateNote extends StatefulWidget {
  final int index;
  final Notes note;
  const UpdateNote({Key? key, required this.index, required this.note})
      : super(key: key);

  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  late final TextEditingController titleController;
  late final TextEditingController bodyController;
  late final int color;
  late final Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('notesBox');
    titleController = TextEditingController(text: widget.note.title);
    bodyController = TextEditingController(text: widget.note.body);
    color = widget.note.color;
  }

  _updateNote() {
    Notes note = Notes(title: titleController.text, body: bodyController.text);
    note.color = color;
    box.putAt(widget.index, note);
    // print('Info Updated to box!');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Note'),
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
              onPressed: () => _updateNote(),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
