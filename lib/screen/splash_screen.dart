import 'dart:async';

import 'package:flutter/material.dart';

import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080705),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB89532).withValues(alpha: 0.20),
                      blurRadius: 90,
                      spreadRadius: 15,
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 145,
                    height: 145,
                    decoration: BoxDecoration(
                      color: const Color(0xFF11151D),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB89532).withValues(alpha: 0.28),
                          blurRadius: 28,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          width: 130,
                          height: 130,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    'AH STORE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 6,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 1,
                        color: const Color(0xFF8E762D),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'CURATED LUXURY &',
                        style: TextStyle(
                          color: Color(0xFFC9AA4A),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 30,
                        height: 1,
                        color: const Color(0xFF8E762D),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'EVERYDAY ESSENTIALS',
                    style: TextStyle(
                      color: Color(0xFF8D8981),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2.2,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: 125,
                    height: 2,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC5A33D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(true),
                      const SizedBox(width: 8),
                      _buildDot(false),
                      const SizedBox(width: 8),
                      _buildDot(false),
                    ],
                  ),
                ],
              ),
            ),

            const Positioned(
              left: 14,
              top: 32,
              child: Text(
                'MAISON\nD’ART',
                style: TextStyle(
                  color: Color(0xFF77736C),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  height: 1.4,
                ),
              ),
            ),

            const Positioned(
              right: 14,
              top: 32,
              child: Text(
                'ED.\n2025',
                style: TextStyle(
                  color: Color(0xFF77736C),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool active) {
    return Container(
      width: active ? 6 : 5,
      height: active ? 6 : 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? const Color(0xFFD2B24C)
            : const Color(0xFF575247),
      ),
    );
  }
}