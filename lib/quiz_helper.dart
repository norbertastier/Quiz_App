import 'dart:io';
import 'package:flutter/services.dart';
import 'package:quiz_app/models/quiz_theme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class QuizHelper {
  static Database _database;
  static QuizHelper _quizHelper;
  static final table = 'theme';

  QuizHelper._privateConstructor();
  static final QuizHelper instance = new QuizHelper._privateConstructor();

  QuizHelper._createInstance();
  factory QuizHelper() {
    if (_quizHelper == null) {
      _quizHelper = QuizHelper._createInstance();
    }
    return _quizHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    final dir = await getDatabasesPath();
    final path = join(dir, '_dataquiz.db');

    final exist = await databaseExists(path);

    if (exist) {
      print("db already exist");
      await openDatabase(path);
    } else {
      print("creating a copy from assets");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "_dataquiz.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
      print("db copied");
    }
    await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await _quizHelper.database;
    var result = await db.rawQuery(table);
    return result.toList();
  }

}
