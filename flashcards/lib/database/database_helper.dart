// ignore_for_file: prefer_conditional_assignment

import 'dart:io';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  Database? _database;

  Future openDb() async {
    if (_database == null) {
      //If Database doesnt exist, then only create the Database
      _database = await openDatabase(join(await getDatabasesPath(), "Title.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE title (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)");
      });
    }
  }

  Future<int> insertTitle(title title) async {
    await openDb();
    return await _database!.insert('title', title.toMap());
  }

  Future<List<title>> getTitleList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('title');
    return List.generate(
        maps.length,
        (i) =>
            title(name: maps[i]['name'], description: maps[i]['description']));
  }

  Future<int> updateTitle(title title) async {
    await openDb();
    // print();
    return await _database!
        .update('title', title.toMap(), where: 'id=?', whereArgs: [title.id]);
  }

  Future<void> deleteTitle(int id) async {
    await openDb();
    await _database!.delete('title', where: 'id=?', whereArgs: [id]);
  }
}

class title {
  int? id;
  String name;
  String description;

  title({this.id, required this.name, required this.description});
  Map<String, dynamic> toMap() {
    return {'name': name, 'course': description};
  }
}
