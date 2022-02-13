import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/screens/addNote.dart';

class ListNotes extends StatefulWidget {
  const ListNotes({Key? key}) : super(key: key);

  @override
  _ListNotesState createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  late final Box noteBox;
  @override
  void initState() {
    noteBox = Hive.box('notesBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddNote(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                var downloadData = currentBox.getAt(index)!;
                return InkWell(
                  onTap: () => {}
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => UpdateScreen(
                  //       index: index,
                  //       person: personData,
                  //     ),
                  //   ),
                  // ),
                  ,
                  child: ListTile(
                    title: Text(downloadData.title),
                    subtitle: Text(downloadData.body),
                    trailing: IconButton(
                      onPressed: () => {}, //deleteNote(index),
                      // _deleteInfo(index),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
