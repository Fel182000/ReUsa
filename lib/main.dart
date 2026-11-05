import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'catalogo_screen.dart';
import 'consejos_screen.dart';
import 'core_theme.dart';
import 'detalle_producto_screen.dart';
import 'favoritos_provider.dart';
import 'favoritos_screen.dart';
import 'formulario_producto_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/catalogo': (context) => const CatalogoScreen(),
        '/detalle': (context) => const DetalleProductoScreen(),
        '/nuevo': (context) => const FormularioProductoScreen(),
        '/favoritos': (context) => const FavoritosScreen(),
        '/consejos': (context) => const ConsejosScreen(),
      },
    );
  }
}