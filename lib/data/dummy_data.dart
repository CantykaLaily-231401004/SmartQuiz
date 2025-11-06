import '../models/question.dart';

class DummyData {
  static List<Question> mathematicsQuestions = [
    Question(
      question: 'Berapakah hasil dari 15 × 8?',
      options: ['100', '120', '130', '140'],
      correctAnswerIndex: 1,
      category: 'Matematika',
    ),
    Question(
      question: 'Jika 3x + 5 = 20, berapakah nilai x?',
      options: ['3', '5', '7', '10'],
      correctAnswerIndex: 1,
      category: 'Matematika',
    ),
    Question(
      question: 'Luas lingkaran dengan jari-jari 7 cm adalah? (π = 22/7)',
      options: ['154 cm²', '54 cm²', '64 cm²', '134 cm²'],
      correctAnswerIndex: 0,
      category: 'Matematika',
    ),
    Question(
      question: 'Hasil dari (8 + 2) × (6 - 3) adalah?',
      options: ['20', '25', '30', '35'],
      correctAnswerIndex: 2,
      category: 'Matematika',
    ),
    Question(
      question: 'Jika harga 5 buku adalah Rp50.000, berapakah harga 8 buku?',
      options: ['Rp70.000', 'Rp75.000', 'Rp80.000', 'Rp85.000'],
      correctAnswerIndex: 2,
      category: 'Matematika',
    ),
  ];

  static List<Question> generalKnowledgeQuestions = [
    Question(
      question: 'Siapakah presiden pertama Indonesia?',
      options: ['Soekarno', 'Soeharto', 'B.J. Habibie', 'Megawati'],
      correctAnswerIndex: 0,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'Proklamasi kemerdekaan Indonesia terjadi pada tanggal?',
      options: ['17 Agustus 1945', '17 Agustus 1944', '17 Agustus 1944', '17 Agustus 1947'],
      correctAnswerIndex: 0,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'Berapa jumlah provinsi di Indonesia saat ini?',
      options: ['34', '35', '36', '38'],
      correctAnswerIndex: 3,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'Planet terbesar di tata surya adalah?',
      options: ['Bumi', 'Mars', 'Jupiter', 'Saturnus'],
      correctAnswerIndex: 2,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'USU (Universitas Sumatera Utara) terletak di kota?',
      options: ['Jakarta', 'Bandung', 'Medan', 'Palembang'],
      correctAnswerIndex: 2,
      category: 'Pengetahuan Umum',
    ),
  ];

  static List<Question> getQuestionsByCategory(String category) {
    if (category == 'Matematika') {
      return mathematicsQuestions;
    } else if (category == 'Pengetahuan Umum') {
      return generalKnowledgeQuestions;
    }
    return [];
  }
}