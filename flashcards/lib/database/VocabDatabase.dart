// ignore_for_file: prefer_conditional_assignment

import 'dart:core';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VocabDatabase {
  Database? _vocabDatabase;

  Future openVocabDatabase() async {
    if (_vocabDatabase == null) {
      //If Database doesnt exist, then only create the Database
      _vocabDatabase = await openDatabase(
          join(await getDatabasesPath(), "vocab.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE nd_title (nd_id INTEGER PRIMARY KEY AUTOINCREMENT, term TEXT, defination TEXT, example TEXT, url TEXT, favorite BOOLEAN, archive BOOLEAN, current_set TEXT, picture BLOB)");
      });
    }
  }

  Future<int> insertVocabCards(VocabCardModal nd_title) async {
    await openVocabDatabase();
    return await _vocabDatabase!.insert('nd_title', nd_title.toMap());
  }

// where: 'nd_id=?', whereArgs: [nd_title.nd_id]

  Future<int> getCount() async {
    await openVocabDatabase();
    List<Map<String, dynamic>> x = await _vocabDatabase!.rawQuery(
        'SELECT COUNT (*) from ${VocabCardModal}'); //TODO WHERE SYMBOL
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  Future<List<VocabCardModal>> getVocabCardsusingCurrentSet(
      String? currentSet) async {
    await openVocabDatabase();
    final List<Map<String, dynamic>> maps = await _vocabDatabase!
        .query('nd_title', where: 'current_set=?', whereArgs: [
      currentSet
    ]); //TODO NEEDS UPDATEFROM FORIGNKEY.dart contact operation
    // await db!.rawQuery('''
    // SELECT * FROM contact
    // WHERE contact.FK_contact_category = ${category.id}
    // ''');
    return List.generate(
        maps.length,
        (i) => VocabCardModal(
            nd_id: maps[i]['nd_id'],
            term: maps[i]['term'],
            defination: maps[i]['defination'],
            example: maps[i]['example'],
            url: maps[i]['url'],
            favorite: maps[i]['favorite'],
            current_set: maps[i]['current_set'],
            archive: maps[i]['archive'],
            picture: maps[i]['picture']));
  }

  //  FirstPagr() async {
  //   await nd_openDb();
  //   final List<Map<String, dynamic>> maps = await _database2!.query('nd_title');
  //   return maps;
  // }

  Future<List<VocabCardModal>> getAllVocabCards() async {
    await openVocabDatabase();
    final List<Map<String, dynamic>> maps = await _vocabDatabase!.query(
        'nd_title'); //TODO NEEDS UPDATEFROM FORIGNKEY.dart contact operation
    // await db!.rawQuery('''
    // SELECT * FROM contact
    // WHERE contact.FK_contact_category = ${category.id}
    // ''');
    return List.generate(
        maps.length,
        (i) => VocabCardModal(
            nd_id: maps[i]['nd_id'],
            term: maps[i]['term'],
            defination: maps[i]['defination'],
            example: maps[i]['example'],
            url: maps[i]['url'],
            favorite: maps[i]['favorite'],
            current_set: maps[i]['current_set'],
            archive: maps[i]['archive'],
            picture: maps[i]['picture']));
  }

  Future<int> updateTitle(VocabCardModal nd_title) async {
    await openVocabDatabase();
    return await _vocabDatabase!.update('nd_title', nd_title.toMap(),
        where: 'nd_id=?', whereArgs: [nd_title.nd_id]);
  }

//TODO
  Future<int> renameCurrent_setListView(
      String currentSet, String newSet, VocabCardModal nd_title) async {
    await openVocabDatabase();
    return await _vocabDatabase!
        .update('nd_title', nd_title.toRenameMap(newSet), // Needs change
            where: 'current_set=?',
            whereArgs: [currentSet]);
  }

  Future<int> updateFavoriteTitle(VocabCardModal nd_title, int favorite) async {
    await openVocabDatabase();
    return await _vocabDatabase!.update(
        'nd_title', nd_title.toFavoriteMap(favorite),
        where: 'nd_id=?', whereArgs: [nd_title.nd_id]);
  }

  Future<void> deleteTitle(int nd_id) async {
    await openVocabDatabase();
    await _vocabDatabase!
        .delete('nd_title', where: 'nd_id=?', whereArgs: [nd_id]);
  }
}
