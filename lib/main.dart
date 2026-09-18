import 'package:flutter/material.dart';

import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AH Store',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B0B0B),
        ),
        useMaterial3: true,
      ),

      // App start hote hi Splash Screen open hogi
      home: const SplashScreen(),
    );
  }
}