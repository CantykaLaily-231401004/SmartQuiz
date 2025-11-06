import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart';
import '../providers/quiz_provider.dart';
import '../widgets/gradient_background.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/custom_button.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCategory = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan masukkan nama Anda')),
      );
      return;
    }

    if (_selectedCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih kategori')),
      );
      return;
    }

    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.setPlayerName(_nameController.text.trim());
    quizProvider.selectCategory(_selectedCategory);

    Navigator.pushNamed(context, AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: ThemeToggle(),
                    ),

                    const SizedBox(height: 40),

                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 300,
                        height: 50,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        'Aplikasi Kuis Pilihan Berganda untuk Menguji Kemampuanmu!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      'Masukkan Nama',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF4A70A9)),
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Nama Kamu',
                          hintStyle: TextStyle(color: Color(0x7A616161), fontSize: 16, fontFamily: 'Poppins'),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'Pilih Kategori',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: CategoryCard(
                            title: 'Matematika',
                            imagePath: 'assets/images/math_illustration.png',
                            isSelected: _selectedCategory == 'Matematika',
                            onTap: () => setState(() => _selectedCategory = 'Matematika'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CategoryCard(
                            title: 'Pengetahuan Umum',
                            imagePath: 'assets/images/general_illustration.png',
                            isSelected: _selectedCategory == 'Pengetahuan Umum',
                            onTap: () => setState(() => _selectedCategory = 'Pengetahuan Umum'),
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 40),

                    CustomButton(
                      text: 'Mulai Kuis',
                      onPressed: _startQuiz,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
