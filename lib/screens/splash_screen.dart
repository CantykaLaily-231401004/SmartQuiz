import 'package:flutter/material.dart';
import '../config/routes.dart';
import '../widgets/gradient_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigasi setelah delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Menggunakan nama rute yang sudah didefinisikan
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan widget GradientBackground yang sudah dibuat
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hanya menampilkan logo
              Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 120,
              ),
              const SizedBox(height: 30),
              // Dan loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
