import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080705),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 25,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ------------------------------------------------
                // LOGO
                // ------------------------------------------------
                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    color: const Color(0xFF11151D),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB89532).withValues(alpha: 0.25),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        width: 110,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // APP NAME
                // ------------------------------------------------
                const Text(
                  'AH STORE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 5,
                  ),
                ),

                const SizedBox(height: 12),

                // ------------------------------------------------
                // GOLD DIVIDER
                // ------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 1,
                      color: const Color(0xFF8E762D),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC9AA4A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 35,
                      height: 1,
                      color: const Color(0xFF8E762D),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // WELCOME TITLE
                // ------------------------------------------------
                const Text(
                  'WELCOME TO AH STORE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD2B24C),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.2,
                  ),
                ),

                const SizedBox(height: 16),

                // ------------------------------------------------
                // DESCRIPTION
                // ------------------------------------------------
                const Text(
                  'Discover a thoughtfully curated collection '
                  'of timeless style and everyday essentials, '
                  'selected to bring quality, elegance, and '
                  'confidence to every choice.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFA09B91),
                    fontSize: 14,
                    height: 1.7,
                    letterSpacing: 0.4,
                  ),
                ),

                const SizedBox(height: 42),

                // ------------------------------------------------
                // LOGIN BUTTON
                // ------------------------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC5A33D),
                      foregroundColor: const Color(0xFF080705),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ------------------------------------------------
                // CONTINUE AS GUEST
                // ------------------------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color(0xFF6F6035),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'CONTINUE AS A GUEST',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ------------------------------------------------
                // BOTTOM TEXT
                // ------------------------------------------------
                const Text(
                  'CURATED STYLE • EVERYDAY ESSENTIALS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF666158),
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.8,
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}