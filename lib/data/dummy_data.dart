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
      question: 'Manakah dari berikut ini yang BUKAN hewan dari Zodiak Tionghoa?',
      options: ['Ayam jago', 'Monyet', 'Babi', 'Gajah'],
      correctAnswerIndex: 3,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'Bendera mana yang berisi lingkaran biru tua di tengahnya yang bertuliskan \'pesanan dan kemajuan\'?',
      options: ['Portugal', 'Tanjung Verde', 'Brasil', 'Suriname'],
      correctAnswerIndex: 2,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'Kota manakah, jika diterjemahkan ke dalam bahasa Inggris, yang berarti \'pertemuan berlumpur\'?',
      options: ['Singapura', 'Jakarta', 'Kuala Lumpur', 'Hongkong'],
      correctAnswerIndex: 2,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'Manakah dari berikut ini yang BUKAN hewan nokturnal?',
      options: ['Luak', 'Serigala', 'Musang', 'Orangutan'],
      correctAnswerIndex: 3,
      category: 'Pengetahuan Umum',
    ),
    Question(
      question: 'Berapa lama waktu yang dibutuhkan cahaya matahari untuk mencapai bumi?',
      options: ['8 detik', '8 menit', '8 jam', '8 hari'],
      correctAnswerIndex: 1,
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