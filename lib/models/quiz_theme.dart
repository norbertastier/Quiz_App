class QuizTheme {
  int thmId;
  String thmName, thmPath;

  QuizTheme(this.thmId, this.thmName, this.thmPath);

  //to be used when updating a row in the table
  Map<String, Object> toMap(){
    return {'id_theme': thmId, 'theme': thmName, 'path': thmPath};
  }

  //to be used when converting the row into object
  QuizTheme.fromMap(Map<String, dynamic> map)
      : thmId = map['id_theme'],
        thmName = map['theme'],
        thmPath = map['path'];
}
