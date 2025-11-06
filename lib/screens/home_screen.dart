import 'dart:math' as math;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCategory = '';
  bool _isDarkMode = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan masukkan nama Anda'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_selectedCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih kategori'), backgroundColor: Colors.red),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Memulai kuis $_selectedCategory untuk ${_nameController.text}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, 0.00),
            end: Alignment(0.50, 1.00),
            colors: [Color(0xFF4A70A9), Color(0xFFEFECE3)],
          ),
        ),
        child: Stack(
          children: [
            // Layer 1: Decorative background blobs
            _buildDecorativeBackground(),

            // Layer 2: Main scrollable content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 19),
                    _buildThemeToggle(),
                    const SizedBox(height: 60),
                    _buildTitle(),
                    const SizedBox(height: 15),
                    _buildSubtitle(),
                    const SizedBox(height: 30), // Jarak diperkecil dari 60 menjadi 40
                    _buildNameInput(),
                    const SizedBox(height: 35),
                    _buildCategorySelection(),
                    const SizedBox(height: 45),
                    _buildStartButton(),
                    const SizedBox(height: 40),
                  ],
                ), 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeBackground() {
    return Stack(
      children: [
        // Top left blob - using image
        Positioned(
          left: -96,
          top: -26,
          child: Transform.rotate(
            angle: -0.55,
            child: Image.asset(
              'assets/images/blob_decoration.png',
              width: 208,
              height: 101,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 208,
                  height: 101,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8FABD4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                );
              },
            ),
          ),
        ),

        // Top left blob 2 - using image
        Positioned(
          left: -96,
          top: 70,
          child: Transform.rotate(
            angle: -0.55,
            child: Image.asset(
              'assets/images/blob_decoration.png',
              width: 208,
              height: 101,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 208,
                  height: 101,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8FABD4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                );
              },
            ),
          ),
        ),

        // Bottom right blob 1 - using image
        Positioned(
          right: -115,
          bottom: -50,
          child: Transform.rotate(
            angle: -3.57,
            child: Image.asset(
              'assets/images/blob_decoration.png',
              width: 208,
              height: 101,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 208,
                  height: 101,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8FABD4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                );
              },
            ),
          ),
        ),

        // Bottom right blob 2 - using image
        Positioned(
          right: -127,
          bottom: 47,
          child: Transform.rotate(
            angle: -3.57,
            child: Image.asset(
              'assets/images/blob_decoration.png',
              width: 208,
              height: 101,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 208,
                  height: 101,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8FABD4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeToggle() {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'Light Mode',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.92,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _isDarkMode = !_isDarkMode),
            child: Container(
              width: 69,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    left: _isDarkMode ? 38 : 6,
                    top: 4,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFCE31),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: 300,
        height: 50,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'SmartQuiz',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0.9,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          'Aplikasi Kuis Pilihan Berganda untuk Menguji Kemampuanmu!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.44,
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 6),
          child: Text(
            'Masukkan Nama',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.44,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: const Color(0xFF4A70A9),
            ),
          ),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Nama Kamu',
              hintStyle: TextStyle(
                color: Color(0x7A616161),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            ),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 6),
          child: Text(
            'Pilih Kategori',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.44,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildCategoryCard(
                'Matematika',
                'assets/images/math_illustration.png',
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _buildCategoryCard(
                'Pengetahuan \nUmum',
                'assets/images/general_illustration.png',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, String imagePath) {
    final isSelected = _selectedCategory == title.replaceAll('\n', ' ').trim();
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = title.replaceAll('\n', ' ').trim()),
      child: Container(
        width: 163,
        height: 163,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: isSelected ? 3 : 1,
            color: isSelected ? const Color(0xFF4A70A9) : const Color(0xFF4A70A9),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  title.contains('Matematika') ? Icons.calculate : Icons.public,
                  size: 70,
                  color: const Color(0xFF4A70A9),
                );
              },
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF092F69),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF4A70A9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _startQuiz,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A70A9),
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Mulai Kuis',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
      ),
    );
  }
}
