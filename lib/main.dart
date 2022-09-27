import 'package:androide_note/views/pages/home.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}


/*
* class MyApp extends StatelessWidget {
  DatabaseSqflite myDB = DatabaseSqflite();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: ()async{
              int response = await myDB.insertData("INSERT INTO 'notes' ('note') VALUES ('note four')");
              print(response);
            }, child: Text("add")),
            ElevatedButton(onPressed: ()async{
              List<Map> response = await myDB.readData("SELECT * FROM 'notes'");
              print(response);
            }, child: Text("read")),
            ElevatedButton(onPressed: ()async{
              int response = await myDB.updateData("UPDATE 'notes' SET 'note' = 'note one' WHERE id = 9");
              print(response);
            }, child: Text("update")),
            ElevatedButton(onPressed: ()async{
              int response = await myDB.deleteData("DELETE FROM 'notes'");
              print(response);
            }, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
* */
