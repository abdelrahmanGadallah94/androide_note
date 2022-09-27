import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSqflite {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    }
    return _db;
  }

  //1- initial database fnc
  initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "abdo.db");

    //create the database structure and put it into the path
    Database myDB = await openDatabase(path, onCreate: _onCreate,version: 16,onUpgrade: _onUpgrade);
    return myDB;
  }

  _onUpgrade(Database db, int oldVresion, int newVersion)async{
    // await db.execute("ALERT TABLE notes ADD COLUMN color TEXT");
    print("upgraded======================================");
  }
  _onCreate(Database db, int version) async {

    Batch batch = db.batch();

    batch.execute('''
      CREATE TABLE "notes"(
      "id"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "title" TEXT NOT NULL,
      "note" TEXT NOT NULL,
      "color" TEXT NOT NULL
      )
      ''',);
    batch.commit();
    print("created database ===============================================");
  }

  //2- insert data in the database
  insertData(String sql) async {
    Database? myDB = await db;
    int? response = await myDB?.rawInsert(sql);
    print(response);
    return response;
  }

  //3- read data fnc
  readData(String sql) async {
    Database ?myDB = await db;
    List<Map> ?response = await myDB?.rawQuery(sql);
    print(response);
    return response;
  }

  //4- delete fnc
  deleteData(String sql)async{
    Database ?myDB = await db;
    int ?response = await myDB?.rawDelete(sql);
    return response;
  }

  //5- update
  updateData(String sql)async{
    Database ?myDB = await db;
    int ?response = await myDB?.rawUpdate(sql);
    return response;
  }

  deleteDB()async{
    String dbPath= await getDatabasesPath();
    String path = join(dbPath,"abdo.db");
    await deleteDatabase(path);
  }
}
