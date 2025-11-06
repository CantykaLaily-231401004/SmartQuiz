import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/dummy_data.dart';

class QuizProvider with ChangeNotifier {
  String _playerName = '';
  String _selectedCategory = '';
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  List<int?> _userAnswers = [];

  // Getters
  String get playerName => _playerName;
  String get selectedCategory => _selectedCategory;
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<int?> get userAnswers => _userAnswers;

  Question? get currentQuestion =>
      _questions.isNotEmpty && _currentQuestionIndex < _questions.length
          ? _questions[_currentQuestionIndex]
          : null;

  int get totalQuestions => _questions.length;

  bool get isLastQuestion => _currentQuestionIndex >= _questions.length - 1;

  // Methods
  void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _questions = DummyData.getQuestionsByCategory(category);
    _userAnswers = List.filled(_questions.length, null);
    _currentQuestionIndex = 0;
    notifyListeners();
  }

  void answerQuestion(int answerIndex) {
    if (_currentQuestionIndex < _questions.length) {
      _userAnswers[_currentQuestionIndex] = answerIndex;
      notifyListeners();
    }
  }
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] == _questions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }
}
