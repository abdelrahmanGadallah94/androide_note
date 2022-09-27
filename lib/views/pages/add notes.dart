import 'package:flutter/material.dart';

import '../../modals/database.dart';
import 'home.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  DatabaseSqflite db = DatabaseSqflite();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              TextFormField(
                controller: color
              ),
              SizedBox(height:15),
              Center(
                child: ElevatedButton(
                  onPressed: ()async{
                    if(title.text.isNotEmpty && note.text.isNotEmpty&& color.text.isNotEmpty){
                      int response = await db.insertData('''
                    INSERT INTO notes(`title`,`note`,`color`) VALUES ("${title.text}","${note.text}","${color.text}")
                    '''
                      );
                      print(response);
                      if(response > 0){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()),(route) => false,);
                      }
                    }
                  },
                  child: Text("Add Notes")
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
