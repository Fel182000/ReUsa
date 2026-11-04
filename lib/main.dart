import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritosProvider(),
      child: const ReusaApp(),
    ),
  );
}

class ReusaApp extends StatelessWidget {
  const ReusaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReUsa Tolcayuca',
      debugShowCheckedModeBanner: false,
      theme: buildReusaTheme(),
      home: const SplashScreen(),
    );
  }
}
