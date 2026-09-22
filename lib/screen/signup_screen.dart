import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
const SignupScreen({super.key});

@override
State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
final TextEditingController _fullNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
TextEditingController();

final AuthService _authService = AuthService();

bool _obscurePassword = true;
bool _obscureConfirmPassword = true;
bool _isLoading = false;

@override
void dispose() {
_fullNameController.dispose();
_emailController.dispose();
_passwordController.dispose();
_confirmPasswordController.dispose();
super.dispose();
}

void _showMessage(String message) {
if (!mounted) return;

ScaffoldMessenger.of(context).hideCurrentSnackBar();

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: const Color(0xFF193754),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

}

void _showSuccessMessage() {
if (!mounted) return;

ScaffoldMessenger.of(context).hideCurrentSnackBar();

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text(
      'Your account has been created successfully.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: const Color(0xFF193754),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);


}

Future<void> _createAccount() async {
FocusScope.of(context).unfocus();

final String fullName = _fullNameController.text.trim();
final String email = _emailController.text.trim();
final String password = _passwordController.text;
final String confirmPassword = _confirmPasswordController.text;

if (fullName.isEmpty) {
  _showMessage('Please enter your full name.');
  return;
}

if (email.isEmpty) {
  _showMessage('Please enter your email address.');
  return;
}

final bool emailIsValid = RegExp(
  r'^[\w\.-]+@[\w\.-]+\.\w+$',
).hasMatch(email);

if (!emailIsValid) {
  _showMessage('Please enter a valid email address.');
  return;
}

if (password.isEmpty) {
  _showMessage('Please enter a password.');
  return;
}

if (password.length < 8) {
  _showMessage('Password must be at least 8 characters.');
  return;
}

final bool hasSpecialCharacter = RegExp(
  r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]+;=]',
).hasMatch(password);

if (!hasSpecialCharacter) {
  _showMessage(
    'Password must contain at least one special character.',
  );
  return;
}

if (confirmPassword.isEmpty) {
  _showMessage('Please confirm your password.');
  return;
}

if (password != confirmPassword) {
  _showMessage('Passwords do not match.');
  return;
}

setState(() {
  _isLoading = true;
});

try {
  await _authService.signUp(
    fullName: fullName,
    email: email,
    password: password,
  );

  if (!mounted) return;

  setState(() {
    _isLoading = false;
  });

  _showSuccessMessage();

  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
    (route) => false,
  );
} on FirebaseAuthException catch (e) {
  if (!mounted) return;

  setState(() {
    _isLoading = false;
  });

  String message =
      'Unable to create your account. Please try again.';

  switch (e.code) {
    case 'email-already-in-use':
      message = 'This email is already registered.';
      break;

    case 'invalid-email':
      message = 'Please enter a valid email address.';
      break;

    case 'weak-password':
      message = 'Please choose a stronger password.';
      break;

    case 'network-request-failed':
      message =
          'Network error. Please check your internet connection.';
      break;

    case 'operation-not-allowed':
      message =
          'Email and password sign up is not enabled.';
      break;

    default:
      message =
          'Unable to create your account. Please try again.';
  }

  _showMessage(message);
} on FirebaseException catch (e) {
  if (!mounted) return;

  setState(() {
    _isLoading = false;
  });

  print('Firebase Error Code: ${e.code}');
  print('Firebase Error Message: ${e.message}');
  print('Firebase Plugin: ${e.plugin}');

  _showMessage(
    'Account was created, but user data could not be saved. Please check Firestore settings.',
  );
} catch (e) {
  if (!mounted) return;

  setState(() {
    _isLoading = false;
  });

  print('Signup Error: $e');

  _showMessage(
    'Something went wrong. Please try again.',
  );
}

}

@override
Widget build(BuildContext context) {
const Color backgroundColor = Color(0xFF080705);
const Color goldColor = Color(0xFFB89532);
const Color fieldColor = Color(0xFF12110F);
const Color borderColor = Color(0xFF2D2A25);
const Color secondaryText = Color(0xFF9D9991);
return Scaffold(
  backgroundColor: backgroundColor,
  body: SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: goldColor.withValues(alpha: 0.20),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          const Center(
            child: Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          const Center(
            child: Text(
              'Create your AH Store account to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 32),

          const Text(
            'Full Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _fullNameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: _inputDecoration(
              hintText: 'Enter your full name',
              icon: Icons.person_outline,
              fieldColor: fieldColor,
              borderColor: borderColor,
              goldColor: goldColor,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: _inputDecoration(
              hintText: 'Enter your email',
              icon: Icons.email_outlined,
              fieldColor: fieldColor,
              borderColor: borderColor,
              goldColor: goldColor,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: _inputDecoration(
              hintText: 'Enter your password',
              icon: Icons.lock_outline,
              fieldColor: fieldColor,
              borderColor: borderColor,
              goldColor: goldColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: secondaryText,
                  size: 20,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Password must be at least 8 characters and contain at least one special character.',
            style: TextStyle(
              color: secondaryText,
              fontSize: 12,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Confirm Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              if (!_isLoading) {
                _createAccount();
              }
            },
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: _inputDecoration(
              hintText: 'Confirm your password',
              icon: Icons.lock_outline,
              fieldColor: fieldColor,
              borderColor: borderColor,
              goldColor: goldColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                  });
                },
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: secondaryText,
                  size: 20,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _createAccount,
              style: ElevatedButton.styleFrom(
                backgroundColor: goldColor,
                disabledBackgroundColor:
                    goldColor.withValues(alpha: 0.45),
                foregroundColor: backgroundColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(
                          Color(0xFF080705),
                        ),
                      ),
                    )
                  : const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 22),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: secondaryText,
                    fontSize: 13,
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
                    'Login',
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    ),
  ),
);
}

InputDecoration _inputDecoration({
required String hintText,
required IconData icon,
required Color fieldColor,
required Color borderColor,
required Color goldColor,
Widget? suffixIcon,
}) {
return InputDecoration(
hintText: hintText,
hintStyle: const TextStyle(
color: Color(0xFF77736C),
fontSize: 14,
),
prefixIcon: Icon(
icon,
color: const Color(0xFF9D9991),
size: 20,
),
suffixIcon: suffixIcon,
filled: true,
fillColor: fieldColor,
contentPadding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 16,
),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
borderSide: BorderSide(
color: borderColor,
),
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
borderSide: BorderSide(
color: borderColor,
),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
borderSide: BorderSide(
color: goldColor,
width: 1.2,
),
),
);
}
}
