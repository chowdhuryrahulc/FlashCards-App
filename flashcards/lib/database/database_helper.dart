// ignore_for_file: prefer_conditional_assignment

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  Database? _database;

  // Future openDb2() async {
  //   print('Terminator ON');
  //   _database = await openDatabase(join(await getDatabasesPath(), "TitleA.db"),
  //       version: 1, onCreate: (Database db, int version) async {
  //     await db.execute(
  //         "CREATE TABLE titleTERMINATOR (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, archive BOOLEAN)");
  //   });
  // }

  Future openDb() async {
    if (_database == null) {
      //If Database doesnt exist, then only create the Database
      _database = await openDatabase(
          join(await getDatabasesPath(), "TitleA.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE title (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, archive BOOLEAN)");
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
        (i) => title(
              id: maps[i]['id'],
              name: maps[i]['name'],
              description: maps[i]['description'],
              archive: maps[i]['archive'],
            ));
  }

  Future<int> updateTitle(title title) async {
    await openDb();
    return await _database!
        .update('title', title.toMap(), where: 'id=?', whereArgs: [title.id]);
  }

  Future<int> updateArchiveTitle(title title, int archive) async {
    await openDb();
    print(archive);
    return await _database!.update('title', title.toArchiveMap(archive),
        where: 'id=?', whereArgs: [title.id]);
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
  int? archive;

  title({this.id, required this.name, required this.description, this.archive});
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description};
  }

  Map<String, dynamic> toArchiveMap(int archive) {
    return {
      'id': id,
      'archive': archive,
    };
  }
}
