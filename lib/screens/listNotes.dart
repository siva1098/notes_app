import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/screens/addNote.dart';
import 'package:notes_app/screens/updateNote.dart';

class ListNotes extends StatefulWidget {
  const ListNotes({Key? key}) : super(key: key);

  @override
  _ListNotesState createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  late final Box noteBox;

  _deleteNote(int index) {
    noteBox.deleteAt(index);
    print('Item deleted from box at index: $index');
  }

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box('notesBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
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
            return ListView.separated(
              padding: const EdgeInsets.all(5.0),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                var downloadData = currentBox.getAt(index)!;
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdateNote(
                        index: index,
                        note: downloadData,
                      ),
                    ),
                  ),
                  child: ListTile(
                    tileColor: Color(downloadData.color).withOpacity(0.3),
                    isThreeLine: true,
                    title: Text(downloadData.title),
                    subtitle: Text(
                      downloadData.body,
                      maxLines: 1,
                    ),
                    trailing: IconButton(
                      onPressed: () => _deleteNote(index),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 6,
              ),
            );
          }
        },
      ),
    );
  }
}
