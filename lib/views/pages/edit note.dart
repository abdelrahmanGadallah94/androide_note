import 'package:flutter/material.dart';

import '../../modals/database.dart';
import 'home.dart';

class Edit extends StatefulWidget {
  String titleText;
  String noteText;
  String color;
  var id;
  Edit(this.titleText, this.noteText,this.color, this.id);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  DatabaseSqflite db = DatabaseSqflite();

  TextEditingController title = TextEditingController();

  TextEditingController note = TextEditingController();

  TextEditingController color = TextEditingController();

  @override
  initState() {
    title.text = widget.titleText;
    note.text = widget.noteText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              controller: title,
            ),
            TextFormField(
              controller: note,
            ),
            TextFormField(controller: color),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    if (title.text.isNotEmpty &&
                        note.text.isNotEmpty &&
                        color.text.isNotEmpty) {
                      int response = await db.updateData(
                          '''
                          UPDATE notes SET note = "${note.text}",
                          title = "${title.text}",
                          color = "${color.text}"
                          WHERE id = ${widget.id}
                          ''');
                      print(response);
                      if (response > 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),

                        );
                      }
                    }
                  },
                  child: Text("Edit Note")),
            )
          ],
        ),
      )),
    );
  }
}
