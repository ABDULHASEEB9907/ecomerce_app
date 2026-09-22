import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final TextEditingController _newPasswordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  static const Color backgroundColor = Color(0xFF080705);
  static const Color goldColor = Color(0xFFB89532);
  static const Color fieldColor = Color(0xFF12110F);
  static const Color borderColor = Color(0xFF2D2A25);
  static const Color secondaryTextColor = Color(0xFF9D9991);

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isValidPassword(String password) {
    // At least 8 characters
    if (password.length < 8) {
      return false;
    }

    // At least one special character
    const String specialCharacters =
        r'!@#$%^&*(),.?":{}|<>_-+=[];`~/\';

    return password
        .split('')
        .any((character) => specialCharacters.contains(character));
  }

  Future<void> _changePassword() async {
    final String currentPassword =
        _currentPasswordController.text.trim();

    final String newPassword =
        _newPasswordController.text.trim();

    final String confirmPassword =
        _confirmPasswordController.text.trim();

    // Check empty fields
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage(
        'Please fill in all password fields.',
      );
      return;
    }

    // Password validation
    if (!_isValidPassword(newPassword)) {
      _showMessage(
        'New password must be at least 8 characters and contain at least one special character.',
      );
      return;
    }

    // Confirm password
    if (newPassword != confirmPassword) {
      _showMessage(
        'New password and confirm password do not match.',
      );
      return;
    }

    // New password must be different
    if (currentPassword == newPassword) {
      _showMessage(
        'New password must be different from your current password.',
      );
      return;
    }

    final User? user = _auth.currentUser;

    if (user == null) {
      _showMessage(
        'Please log in again to change your password.',
      );
      return;
    }

    if (user.email == null || user.email!.isEmpty) {
      _showMessage(
        'Unable to change password for this account.',
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Re-authenticate user with current password
      final AuthCredential credential =
          EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(
        credential,
      );

      // Update password in Firebase Authentication
      await user.updatePassword(
        newPassword,
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password changed successfully.',
          ),
        ),
      );

      Future.delayed(
        const Duration(milliseconds: 800),
        () {
          if (mounted) {
            Navigator.pop(context);
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      String message;

      switch (e.code) {
        case 'wrong-password':
        case 'invalid-credential':
          message = 'Current password is incorrect.';
          break;

        case 'weak-password':
          message =
              'New password is too weak. Please use at least 8 characters and one special character.';
          break;

        case 'requires-recent-login':
          message =
              'Please log in again and then try changing your password.';
          break;

        case 'network-request-failed':
          message =
              'Network error. Please check your internet connection.';
          break;

        case 'too-many-requests':
          message =
              'Too many attempts. Please try again later.';
          break;

        default:
          message =
              'Unable to change password. Please try again.';
      }

      _showMessage(message);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      _showMessage(
        'Unable to change password. Please try again later.',
      );
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool showPassword,
    required VoidCallback onVisibilityPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          obscureText: !showPassword,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: secondaryTextColor,
              fontSize: 14,
            ),
            filled: true,
            fillColor: fieldColor,

            prefixIcon: const Icon(
              Icons.lock_outline,
              color: goldColor,
              size: 21,
            ),

            suffixIcon: IconButton(
              onPressed: onVisibilityPressed,
              icon: Icon(
                showPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: secondaryTextColor,
                size: 21,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: borderColor,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: goldColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          10,
          16,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update your password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Enter your current password and choose a new password for your account.',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 28),

            _buildPasswordField(
              controller: _currentPasswordController,
              label: 'Current Password',
              hint: 'Enter current password',
              showPassword: _showCurrentPassword,
              onVisibilityPressed: () {
                setState(() {
                  _showCurrentPassword =
                      !_showCurrentPassword;
                });
              },
            ),

            const SizedBox(height: 20),

            _buildPasswordField(
              controller: _newPasswordController,
              label: 'New Password',
              hint: 'Enter new password',
              showPassword: _showNewPassword,
              onVisibilityPressed: () {
                setState(() {
                  _showNewPassword =
                      !_showNewPassword;
                });
              },
            ),

            const SizedBox(height: 20),

            _buildPasswordField(
              controller: _confirmPasswordController,
              label: 'Confirm New Password',
              hint: 'Re-enter new password',
              showPassword: _showConfirmPassword,
              onVisibilityPressed: () {
                setState(() {
                  _showConfirmPassword =
                      !_showConfirmPassword;
                });
              },
            ),

            const SizedBox(height: 14),

            const Text(
              'Password must be at least 8 characters and contain at least one special character.',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 12,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed:
                    _isLoading ? null : _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  foregroundColor: Colors.black,
                  disabledBackgroundColor:
                      goldColor.withOpacity(0.45),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 23,
                        height: 23,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor:
                              AlwaysStoppedAnimation<
                                  Color>(
                            Colors.black,
                          ),
                        ),
                      )
                    : const Text(
                        'Save Password',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}