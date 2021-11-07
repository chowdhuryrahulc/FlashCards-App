// ignore_for_file: prefer_conditional_assignment

import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBManager2 {
  Database? _database2;

  Future nd_openDb() async {
    if (_database2 == null) {
      //If Database doesnt exist, then only create the Database
      _database2 = await openDatabase(
          join(await getDatabasesPath(), "Title2.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE nd_title (nd_id INTEGER PRIMARY KEY AUTOINCREMENT, term TEXT, defination TEXT, example TEXT, url TEXT, favorite BOOL, archive BOOL, current_set TEXT)");
      });
    }
  }

  Future<int> insertTitle(nd_title nd_title) async {
    await nd_openDb();
    return await _database2!.insert('nd_title', nd_title.toMap());
  }

  Future<List<nd_title>> getnd_TitleList() async {
    await nd_openDb();
    final List<Map<String, dynamic>> maps = await _database2!.query('nd_title');
    return List.generate(
        maps.length,
        (i) => nd_title(
              nd_id: maps[i]['nd_id'],
              term: maps[i]['term'],
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
    return await _database2!.update('nd_title', nd_title.toMap(),
        where: 'id=?', whereArgs: [nd_title.nd_id]);
  }

  Future<void> deleteTitle(int nd_id) async {
    await nd_openDb();
    await _database2!.delete('nd_title', where: 'id=?', whereArgs: [nd_id]);
  }
}

class nd_title {
  int? nd_id;
  String term;
  String defination;
  String? example;
  String? url;
  bool? favorite;
  String? current_set;
  bool? archive;

  nd_title(
      {this.nd_id,
      required this.term,
      required this.defination,
      this.example,
      this.url,
      this.favorite,
      this.current_set,
      this.archive});
  Map<String, dynamic> toMap() {
    return {
      'nd_id': nd_id,
      'term': term,
      'defination': defination,
      'example': example,
      'url': url,
      'favorite': favorite,
      'current_set': current_set,
      'archive': archive
    };
  }
}
