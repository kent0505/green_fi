import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/cash.dart';
import 'models/saving.dart';
import 'utils.dart';

class Db {
  late Database _db;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('onboard');
    // await prefs.clear();
    onboarding = prefs.getBool('onboarding') ?? true;
    score = prefs.getInt('score') ?? 0;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'green_fi.db');
    // await deleteDatabase(path);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE cash (id INTEGER, title TEXT, amount INTEGER, category TEXT)');
        await db.execute(
            'CREATE TABLE saving (id INTEGER, category TEXT, amount INTEGER)');
      },
    );
  }

  Future<List<Cash>> getCashes() async {
    final List<Map<String, dynamic>> maps = await _db.query('cash');
    return List.generate(maps.length, (index) => Cash.fromMap(maps[index]));
  }

  Future<List<Cash>> addCash(Cash cash) async {
    await _db.insert(
      'cash',
      cash.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return await getCashes();
  }

  Future<List<Cash>> editCash(Cash cash) async {
    await _db.update(
      'cash',
      cash.toMap(),
      where: 'id = ?',
      whereArgs: [cash.id],
    );
    return await getCashes();
  }

  Future<List<Cash>> deleteCash(Cash cash) async {
    await _db.delete(
      'cash',
      where: 'id = ?',
      whereArgs: [cash.id],
    );
    return await getCashes();
  }

  Future<List<Saving>> getSavings() async {
    final List<Map<String, dynamic>> maps = await _db.query('saving');
    return List.generate(maps.length, (index) => Saving.fromMap(maps[index]));
  }

  Future<List<Saving>> addSaving(Saving saving) async {
    await _db.insert(
      'saving',
      saving.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return await getSavings();
  }

  Future<List<Saving>> editSaving(Saving saving) async {
    await _db.update(
      'saving',
      saving.toMap(),
      where: 'id = ?',
      whereArgs: [saving.id],
    );
    return await getSavings();
  }

  Future<List<Saving>> deleteSaving(Saving saving) async {
    await _db.delete(
      'saving',
      where: 'id = ?',
      whereArgs: [saving.id],
    );
    return await getSavings();
  }
}
