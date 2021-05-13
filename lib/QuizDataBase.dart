import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:quiz_app/models/quiz_theme.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quiz_app/getExcel.dart';
import 'dart:io';
import 'package:excel/excel.dart';

class QuizDataBase {
  QuizDataBase._();


  static final QuizDataBase instance = QuizDataBase._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'quiz_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE theme(id_theme INTEGER NOT NULL, theme TEXT NOT NULL, path TEXT NOT NULL, PRIMARY KEY('id_theme' AUTOINCREMENT));"
          "CREATE TABLE question(id_question INTEGER NOT NULL, question TEXT NOT NULL, type TEXT NOT NULL, answers TEXT, correct TEXT, enable INTEGER NOT NULL, theme INTEGER NOT NULL, PRIMARY KEY('id_question' AUTOINCREMENT), FOREIGN KEY(theme) REFERENCES theme(id_theme)); ",
        );
      },
      version: 1,
    );
  }

  void insertTheme(QuizTheme theme) async {
    final Database db = await database;

    await db.insert('theme', theme.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void updateTheme(QuizTheme theme) async {
    final Database db = await database;
    db.update('theme', theme.toMap(),
        where: "id_theme = ?", whereArgs: [theme.thmId]);
  }

  void deleteTheme(int idtheme) async {
    final Database db = await database;
    db.delete('theme', where: "id_theme = ?", whereArgs: [idtheme]);
  }

  Future<List<QuizTheme>> themes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('theme');
    List<QuizTheme> themes = List.generate(maps.length, (i) {
      return QuizTheme.fromMap(maps[i]);
    });
    if (themes.isEmpty) {
      for (QuizTheme theme in defaultThemes) {
        insertTheme(theme);
      }
      themes = defaultThemes;
    }
    return themes;
  }

  void insertQuestion(QuizQuestion question) async {
    final Database db = await database;

    await db.insert('question', question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void updateQuestion(QuizQuestion question) async {
    final Database db = await database;
    db.update('question', question.toMap(),
        where: "id_question = ?", whereArgs: [question.id_question]);
  }

  void deleteQuestion(int idquestion) async {
    final Database db = await database;
    db.delete('question', where: "id_question = ?", whereArgs: [idquestion]);
  }

  Future<List<QuizQuestion>> questions() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('question');
    List<QuizQuestion> questions = List.generate(maps.length, (i) {
      return QuizQuestion.fromMap(maps[i]);
    });
    if (questions.isEmpty) {
      for (QuizQuestion question in defaultQuestions) {
        insertQuestion(question);
      }
      questions = defaultQuestions;
    }
    return questions;
  }

  Future<List<QuizQuestion>> questionstheme(int idtheme) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM question WHERE theme == $idtheme");
    List<QuizQuestion> questions = List.generate(maps.length, (i) {
      return QuizQuestion.fromMap(maps[i]);
    });
    if (questions.isEmpty) {
      for (QuizQuestion question in defaultQuestions) {
        insertQuestion(question);
      }
      questions = defaultQuestions;
    }
    return questions;
  }

  final List<QuizTheme> defaultThemes = [
    QuizTheme(1, 'Sport', 'assets/sport.png'),
    QuizTheme(2, 'Histoire', 'assets/history.png'),
    QuizTheme(3, 'Science', 'assets/science.png')
  ];

  final List<QuizQuestion> defaultQuestions = [
    QuizQuestion(1, 'Mon nom est-il Astier ?', 1, '', 'Vrai', 0, 1),
    QuizQuestion(2, 'Mon prénom est-il Astier ?', 1, '', 'Faux', 0, 1),
    QuizQuestion(3, 'Ai-je 18 ans ?', 1, '', 'Faux', 0, 1),
    QuizQuestion(4, 'Complétez l\'expression : Qui vole un œuf vole…', 2, 'Un keuf,Un oeuf,Un neuf,Un boeuf', 'Un boeuf', 0, 1),
  ];
}

