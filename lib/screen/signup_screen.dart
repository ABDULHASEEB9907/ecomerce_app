import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080705),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // ------------------------------------------------
                // LOGO
                // ------------------------------------------------
                Container(
                  width: 115,
                  height: 115,
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
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------------------------------------
                // TITLE
                // ------------------------------------------------
                const Text(
                  'CREATE ACCOUNT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3.5,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Create your AH STORE account and start exploring.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9E998F),
                    fontSize: 13,
                    letterSpacing: 0.4,
                  ),
                ),

                const SizedBox(height: 32),

                // ------------------------------------------------
                // FULL NAME
                // ------------------------------------------------
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FULL NAME',
                    style: TextStyle(
                      color: Color(0xFFC9AA4A),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),

                const SizedBox(height: 9),

                TextField(
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: _inputDecoration(
                    hintText: 'Enter your full name',
                    icon: Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // EMAIL
                // ------------------------------------------------
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'EMAIL ADDRESS',
                    style: TextStyle(
                      color: Color(0xFFC9AA4A),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),

                const SizedBox(height: 9),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: _inputDecoration(
                    hintText: 'Enter your email address',
                    icon: Icons.email_outlined,
                  ),
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // PASSWORD
                // ------------------------------------------------
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PASSWORD',
                    style: TextStyle(
                      color: Color(0xFFC9AA4A),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),

                const SizedBox(height: 9),

                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: _inputDecoration(
                    hintText: 'Create a password',
                    icon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF8E8060),
                        size: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 9),

                // ------------------------------------------------
                // PASSWORD REQUIREMENT
                // ------------------------------------------------
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color(0xFF746B58),
                        size: 15,
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Password must contain at least one special character',
                          style: TextStyle(
                            color: Color(0xFF746F66),
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // CONFIRM PASSWORD
                // ------------------------------------------------
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CONFIRM PASSWORD',
                    style: TextStyle(
                      color: Color(0xFFC9AA4A),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),

                const SizedBox(height: 9),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: _inputDecoration(
                    hintText: 'Confirm your password',
                    icon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                              !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF8E8060),
                        size: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ------------------------------------------------
                // SIGN UP BUTTON
                // ------------------------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
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
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------------------------------------
                // LOGIN OPTION
                // ------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Color(0xFF777168),
                        fontSize: 12.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Color(0xFFD2B24C),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ------------------------------------------------
                // BRANDING
                // ------------------------------------------------
                const Text(
                  'AH STORE  •  CURATED STYLE',
                  style: TextStyle(
                    color: Color(0xFF575149),
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.7,
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // REUSABLE INPUT DECORATION
  // ==============================================================

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF666158),
        fontSize: 13,
      ),
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF9A8236),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFF11100D),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFF3D3728),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFF3D3728),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFC5A33D),
          width: 1.2,
        ),
      ),
    );
  }
}