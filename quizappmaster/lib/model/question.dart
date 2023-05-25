class Question {
  late  String category;
  late  String type;
  late  String difficulty;
  late  String question;
  late  String correctAnswer;
  late List<String> incorrectAnswers;

  Question(
      {required this.category,
        required this.type,
        required this.difficulty,
        required this.question,
        required this.correctAnswer,
        required this.incorrectAnswers});

  Question.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    data['difficulty'] = this.difficulty;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['incorrect_answers'] = this.incorrectAnswers;
    return data;
  }
}
