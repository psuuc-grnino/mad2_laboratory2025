import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:nino_hiverealm/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  late Realm realm;
  late RealmResults<Items> item;
  final itemCtrl = TextEditingController();

  void initRealm() {
    var config = Configuration.local([Items.schema]);
    realm = Realm(config);
    loadItems();
  }

  void loadItems() {
    item = realm.all<Items>();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initRealm();
  }

  void addItem() {
    realm.write(() {
      var item = Items(itemCtrl.text);
      realm.add(item);
      print(Text('added'));
      loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Realm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: itemCtrl,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
              onPressed: addItem,
              child: Text('Add'),
            ),
           Expanded(child:  
           ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  var itemss = item[index];
                  return Dismissible(
                    key: UniqueKey(),
                    child: Card(
                      child: ListTile(
                        title: Text(itemss.item),
                      ),
                    ),
                  );
                }),
                ),
          ],
        ),
      ),
    );
  }
}
