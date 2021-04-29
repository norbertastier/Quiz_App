class QuizQuestion {
  QuizQuestion({
    this.id_question,
    this.question,
    this.type,
    this.answers,
    this.correct,
    this.enable,
    this.theme,
  });

  int id_question;
  String question;
  String type;
  String answers;
  String correct;
  int enable;
  int theme;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
    id_question: json["id_question"],
    question: json["question"],
    type: json["type"],
    answers: json["answers"],
    correct: json["correct"],
    enable: json["enable"],
    theme: json["theme"],
  );

  Map<String, dynamic> toJson() => {
    "id_question": id_question,
    "question": question,
    "type": type,
    "answers":answers,
    "correct": correct,
    "enable": enable,
    "theme": theme,
  };
}