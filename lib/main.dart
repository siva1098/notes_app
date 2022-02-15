import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/list_notes.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());
  await Hive.openBox('notesBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListNotes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
