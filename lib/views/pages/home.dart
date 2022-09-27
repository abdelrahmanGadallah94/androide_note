import 'package:flutter/material.dart';

import '../../modals/database.dart';
import 'add notes.dart';
import 'edit note.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseSqflite db = DatabaseSqflite();

  List notes = [];

  bool isLoading = true;

  readDB() async {
    List response = await db.readData("SELECT * FROM notes");

    notes.addAll(response);

    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  initState() {
    readDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AddNotes()));
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true ? Center(child: Text("loading......"),): Column(
        children: [
          ElevatedButton(
              onPressed: () {
                db.deleteDB();
              },
              child: Text("delete db")),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, i) {
                    return Card(
                      child: (ListTile(
                        title: Text("${notes[i]["title"]}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                int response = await db.deleteData('''
                                 DELETE FROM notes WHERE id = ${notes[i]["id"]}
                                 ''');
                                if (response > 0) {
                                  notes.removeWhere((element) => element["id"] == notes[i]["id"]);
                                  setState((){});
                                }
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            IconButton(
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    Edit("${notes[i]["title"]}", "${notes[i]["note"]}","${notes[i]["color"]}", "${notes[i]["id"]}")
                                ));
                              },
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        subtitle: Text("${notes[i]["note"]}"),
                      )),
                    );
                  },
                  separatorBuilder: (context, i) => Divider(),
                  itemCount: notes.length))
        ],
      ),
    );
  }
}
