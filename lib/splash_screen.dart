import 'package:flutter/material.dart';

import 'core_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/catalogo');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primario,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.recycling, size: 100, color: Colors.white),
            SizedBox(height: AppSpacing.md),
            Text(
              'ReUsa Tolcayuca',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Dale una segunda vida a tus cosas',
              style: TextStyle(fontSize: 15, color: AppColors.primarioClaro),
            ),
          ],
        ),
      ),
    );
  }
}
