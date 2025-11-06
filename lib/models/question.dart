class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String category;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
  });

  String get correctAnswer => options[correctAnswerIndex];
}