import 'package:quiz_app/models/quiz_theme.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/themes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableTheme = 'theme';
final String columnId = 'id_theme';
final String columnTheme = 'theme';
final String columnPath = 'path';

final String tableQuestion = 'question';
final String columnIdQuestion = 'id_question';
final String columnQuestion = 'question';
final String columnType = 'type';
final String columnAnswers = 'answers';
final String columnCorrect = 'correct';
final String columnEnable = 'enable';
final String columnThemeQuestion = 'theme';

class QuizHelper {
  static Database _database;
  static QuizHelper _quizHelper;

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
    var dir = await getDatabasesPath();
    var path = dir + "quiz.db";
    print(path);

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
           CREATE TABLE IF NOT EXISTS $tableTheme(
           $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
           $columnTheme TEXT not null,
           $columnPath TEXT not null)
        ''');
        await db.execute('''
           CREATE TABLE IF NOT EXISTS $tableQuestion(
           $columnIdQuestion INTEGER PRIMARY KEY AUTOINCREMENT,
           $columnQuestion TEXT not null,
           $columnType TEXT not null,
           $columnAnswers TEXT,
           $columnCorrect TEXT not null,
           $columnEnable TEXT not null,
           $columnThemeQuestion TEXT
           )
        ''');
        Themes().inputTheme(db);
      },
    );
    return database;
  }

  void insertTheme(QuizTheme QuizTheme) async {
    var db = await this.database;
    var result = await db.insert(tableTheme, QuizTheme.toJson());
    print("result : $result");
  }
}
