class QuizQuestion {
  int id_question, enable, theme;
  String question, type, answers, correct;

  QuizQuestion(
    this.id_question,
    this.question,
    this.type,
    this.answers,
    this.correct,
    this.enable,
    this.theme,
  );

  Map<String, dynamic> toMap() {
    return {
      'id_question': id_question,
      'question': question,
      'type': type,
      'answers': answers,
      'correct': correct,
      'enable': enable,
      'theme': theme
    };
  }

  factory QuizQuestion.fromMap(Map<String, dynamic> map) => new QuizQuestion(
      map['question'],
      map['question'],
      map['type'],
      map['answers'],
      map['correct'],
      map['enable'],
      map['theme']);
}
