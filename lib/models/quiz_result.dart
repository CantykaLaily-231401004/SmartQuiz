class QuizResult {
  final String playerName;
  final String category;
  final int score;
  final int totalQuestions;
  final List<int?> userAnswers;
  final DateTime completedAt;

  QuizResult({
    required this.playerName,
    required this.category,
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.completedAt,
  });

  int get correctAnswers => score;
  int get wrongAnswers => totalQuestions - score;
  double get percentage => (score / totalQuestions) * 100;
}