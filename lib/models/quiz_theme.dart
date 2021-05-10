class QuizTheme {
  int thmId;
  String thmName, thmPath;

  QuizTheme(this.thmId, this.thmName, this.thmPath);

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    return {'id_theme': thmId, 'theme': thmName, 'path': thmPath};
  }

  //to be used when converting the row into object
  factory QuizTheme.fromMap(Map<String, dynamic> map) =>
      new QuizTheme(map['id_theme'], map['theme'], map['path']);
}
