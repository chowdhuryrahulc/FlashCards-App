// ignore_for_file: prefer_conditional_assignment

import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBManager2 {
  Database? _database;

  Future nd_openDb() async {
    if (_database == null) {
      //If Database doesnt exist, then only create the Database
      _database = await openDatabase(join(await getDatabasesPath(), "Title.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE nd_title (nd_id INTEGER PRIMARY KEY AUTOINCREMENT, word TEXT, defination TEXT, example TEXT, url TEXT, favorite BOOL, archive BOOL, current_set TEXT)");
      });
    }
  }

  Future<int> insertTitle(nd_title nd_title) async {
    await nd_openDb();
    return await _database!.insert('nd_title', nd_title.toMap());
  }

  Future<List<nd_title>> getnd_TitleList() async {
    await nd_openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('nd_title');
    return List.generate(
        maps.length,
        (i) => nd_title(
              nd_id: maps[i]['nd_id'],
              word: maps[i]['word'],
              defination: maps[i]['defination'],
              example: maps[i]['example'],
              url: maps[i]['url'],
              favorite: maps[i]['favorite'],
              current_set: maps[i]['current_set'],
              archive: maps[i]['archive'],
            ));
  }

  Future<int> updateTitle(nd_title nd_title) async {
    await nd_openDb();
    // print();
    return await _database!.update('nd_title', nd_title.toMap(),
        where: 'id=?', whereArgs: [nd_title.nd_id]);
  }

  Future<void> deleteTitle(int nd_id) async {
    await nd_openDb();
    await _database!.delete('nd_title', where: 'id=?', whereArgs: [nd_id]);
  }
}

class nd_title {
  int? nd_id;
  String word;
  String defination;
  String example;
  String url;
  bool favorite;
  String current_set;
  bool archive;

  nd_title(
      {this.nd_id,
      required this.word,
      required this.defination,
      required this.example,
      required this.url,
      required this.favorite,
      required this.current_set,
      required this.archive});
  Map<String, dynamic> toMap() {
    return {
      'nd_id': nd_id,
      'name': word,
      'defination': defination,
      'example': example,
      'url': url,
      'favorite': favorite,
      'current_set': current_set,
      'archive': archive
    };
  }
}
