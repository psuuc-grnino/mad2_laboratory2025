import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NotesScreen> {
  late Box box;
  final noteCtrl = TextEditingController();
  final editCtrl = TextEditingController();
  List notes = [];

  void initBox() async {
    box = await Hive.openBox('notes');
    loadBox();
  }

  void loadBox() async {
    notes = box.values.toList();
    setState(() {});
    print(notes);
  }

  @override
  void initState() {
    super.initState();
    initBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),P
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (_, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                doDelete(index);
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    notes.elementAt(index),
                  ),
                  onTap: () => showDialog(
                    context: context, 
                    builder:(_){
                      return AlertDialog(
                        title: Text('Edit Note'),
                        content: TextField(),
                        actions: [
                         TextButton(onPressed: (){}, child: Text('Edit'))
                        ],
                      );

                    },
                  
                ),
              ),
            );
          },
          itemCount: notes.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddNote,
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddNote() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Add Note'),
            content: TextField(
              controller: noteCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              ElevatedButton(onPressed: doAdd, child: const Text('Add'))
            ],
          );
        });
  }

  void doAdd() {
    box.add(noteCtrl.text);
    Navigator.of(context).pop();
    noteCtrl.clear();
    loadBox();
    print('added note');
  }

  void doDelete(int i) {
    box.deleteAt(i);
    loadBox();
  }
}

void doEdit() {}
