import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:realm/realm.dart';
import 'package:realm_lecture/note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Realm realm;
  late RealmResults<Note> notes;

  var titleCtrl = TextEditingController();
  var contentCtrl = TextEditingController();

  var editTitleCtrl = TextEditingController();
  var editContentCtrl = TextEditingController();

  initRealm() {
    var config = Configuration.local([Note.schema]);
    realm = Realm(config);
    loadNotes();
  }

  void loadNotes() {
    notes = realm.all<Note>();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initRealm();
  }

  void doAdd() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Add note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
              ),
              Gap(10),
              TextField(
                controller: contentCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Content'),
                ),
                maxLines: 6,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var config = Configuration.local([Note.schema]);
                var realm = Realm(config);

                var note = Note(titleCtrl.text, contentCtrl.text,date: DateTime.now());
                realm.write(() {
                  realm.add(note);
                  print('new note added');
                  loadNotes();
                });
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoteApp Realm'),
        actions: [IconButton(
          onPressed: (){
            
          }, 
          icon: Icon(Icons.search)
          ),
          ],
        backgroundColor: Colors.purple[200],
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          Note note = notes[index];
          return Dismissible(
            background: Container(
              child: Row(
                children: [
                  Gap(10),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ],
              ),
              color: Colors.red.shade400,
            ),
            key: UniqueKey(),
            onDismissed: (direction) {
              realm.write(() {
                realm.delete(note);
                print('note deleted');
                loadNotes();
              });
            },
            child: GestureDetector(
              onTap: () {
                doEdit(note);
              },
              child: Card(
                shape: RoundedRectangleBorder(),
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: Text(note.date.toString()),
                ),
              ),
            ),
          );
        },
        itemCount: notes.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: doAdd,
        child: Icon(Icons.add),
      ),
    );
  }

  void doEdit(Note note) {
    editTitleCtrl.text = note.title;
    editContentCtrl.text = note.content;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Edit note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: editTitleCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(note.title),
                  ),
                ),
                Gap(10),
                TextField(
                  controller: editContentCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(note.content),
                  ),
                  maxLines: 6,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  realm.write(() {
                    note.title = editTitleCtrl.text;
                    note.content = editContentCtrl.text;
                    loadNotes();
                  });
                },
                child: Text("Edit"),
              ),
            ],
            
          );
        });
  }

  void doSearch(Note note){

  }
}
