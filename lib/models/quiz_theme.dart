class QuizTheme {
  QuizTheme({
    this.id,
    this.theme,
    this.path,
  });

  int id;
  String theme;
  String path;

  factory QuizTheme.fromJson(Map<String, dynamic> json) => QuizTheme(
    id: json["id"],
    theme: json["theme"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "theme": theme,
    "path": path,
  };
}