import 'package:sqflite/sqflite.dart';

class Themes {
  void inputTheme(Database db) async {
    await db.execute("INSERT INTO theme(theme,path) VALUES ('Sport','assets/sport.png');");
    print("-------theme");
  }
}
