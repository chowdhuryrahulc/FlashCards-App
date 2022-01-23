// ignore_for_file: prefer_conditional_assignment

import 'package:flashcards/Modals/headlineModal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HeadlineDatabase {
  Database? _headlineDatabase;

  // Future openDb2() async {
  //   print('Terminator ON');
  //   _database = await openDatabase(join(await getDatabasesPath(), "TitleA.db"),
  //       version: 1, onCreate: (Database db, int version) async {
  //     await db.execute(
  //         "CREATE TABLE titleTERMINATOR (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, archive BOOLEAN)");
  //   });
  // }

  Future openDb() async {
    if (_headlineDatabase == null) {
      //If Database doesnt exist, then only create the Database
      _headlineDatabase = await openDatabase(
          join(await getDatabasesPath(), "TitleA.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE title (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, archive BOOLEAN)");
      });
    }
  }

  Future<int> insertTitle(Headlines title) async {
    await openDb();
    return await _headlineDatabase!.insert('title', title.toMap());
  }

  Future<List<Headlines>> getTitleList() async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _headlineDatabase!.query('title');
    return List.generate(
        maps.length,
        (i) => Headlines(
              id: maps[i]['id'],
              name: maps[i]['name'],
              description: maps[i]['description'],
              archive: maps[i]['archive'],
            ));
  }

  Future<int> updateTitle(Headlines title) async {
    await openDb();
    return await _headlineDatabase!
        .update('title', title.toMap(), where: 'id=?', whereArgs: [title.id]);
  }

  Future<int> updateArchiveTitle(Headlines title, int archive) async {
    await openDb();
    print(archive);
    return await _headlineDatabase!.update('title', title.toArchiveMap(archive),
        where: 'id=?', whereArgs: [title.id]);
  }

  Future<void> deleteTitle(int id) async {
    await openDb();
    await _headlineDatabase!.delete('title', where: 'id=?', whereArgs: [id]);
  }
}
