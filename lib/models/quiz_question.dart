class QuizQuestion {
  int id_question, enable, theme, type;
  String question, answers, correct;

  QuizQuestion(
    this.id_question,
    this.question,
    this.type,
    this.answers,
    this.correct,
    this.enable,
    this.theme,
  );

  Map<String, Object> toMap() {
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

  QuizQuestion.fromMap(Map<String, dynamic> map)
      : id_question = map['id_question'],
        question = map['question'],
        type = map['type'],
        answers = map['answers'],
        correct = map['correct'],
        enable = map['enable'],
        theme = map['theme'];
}
