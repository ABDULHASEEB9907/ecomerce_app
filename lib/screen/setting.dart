import 'package:flutter/material.dart';

import 'change_password.dart';
import 'privacy_policy.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  String selectedLanguage = 'English';

  static const Color backgroundColor = Color(0xFF080705);
  static const Color goldColor = Color(0xFFB89532);
  static const Color cardColor = Color(0xFF12110F);
  static const Color borderColor = Color(0xFF2D2A25);
  static const Color secondaryTextColor = Color(0xFF9D9991);

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Select Language',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                language: 'English',
              ),
              const Divider(
                color: borderColor,
                height: 1,
              ),
              _buildLanguageOption(
                language: 'Urdu',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required String language,
  }) {
    final bool isSelected = selectedLanguage == language;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        language,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        isSelected
            ? Icons.radio_button_checked
            : Icons.radio_button_unchecked,
        color: isSelected
            ? goldColor
            : secondaryTextColor,
      ),
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });

        Navigator.pop(context);

        ScaffoldMessenger.of(this.context).showSnackBar(
          SnackBar(
            content: Text(
              '$language selected.',
            ),
          ),
        );
      },
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
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ============================================================
            // GENERAL
            // ============================================================

            const Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 10,
              ),
              child: Text(
                'General',
                style: TextStyle(
                  color: goldColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildSettingsCard(
              child: Column(
                children: [

                  // Notifications

                  SwitchListTile(
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                    activeThumbColor: goldColor,
                    activeTrackColor:
                        goldColor.withOpacity(0.35),
                    inactiveThumbColor:
                        secondaryTextColor,
                    inactiveTrackColor: borderColor,
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    secondary: const Icon(
                      Icons.notifications_outlined,
                      color: goldColor,
                      size: 25,
                    ),
                    title: const Text(
                      'Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      'Manage your notification preferences',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  _buildDivider(),

                  // Language

                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    leading: const Icon(
                      Icons.language,
                      color: goldColor,
                      size: 25,
                    ),
                    title: const Text(
                      'Language',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      selectedLanguage,
                      style: const TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: _showLanguageDialog,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ============================================================
            // ACCOUNT & SECURITY
            // ============================================================

            const Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 10,
              ),
              child: Text(
                'Account & Security',
                style: TextStyle(
                  color: goldColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildSettingsCard(
              child: Column(
                children: [

                  // ======================================================
                  // CHANGE PASSWORD
                  // ======================================================

                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    leading: const Icon(
                      Icons.lock_outline,
                      color: goldColor,
                      size: 25,
                    ),
                    title: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      'Update your account password',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),

                  _buildDivider(),

                  // ======================================================
                  // PRIVACY & SECURITY
                  // ======================================================

                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    leading: const Icon(
                      Icons.security_outlined,
                      color: goldColor,
                      size: 25,
                    ),
                    title: const Text(
                      'Privacy & Security',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      'Manage your privacy and security',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: secondaryTextColor,
                    ),

                    // ==================================================
                    // CONNECT TO PRIVACY POLICY SCREEN
                    // ==================================================

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ============================================================
            // ABOUT
            // ============================================================

            const Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 10,
              ),
              child: Text(
                'About',
                style: TextStyle(
                  color: goldColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildSettingsCard(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                leading: const Icon(
                  Icons.info_outline,
                  color: goldColor,
                  size: 25,
                ),
                title: const Text(
                  'About AH Store',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'App information and version',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 13,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: secondaryTextColor,
                ),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'AH Store',
                    applicationVersion: '1.0.0',
                    applicationLegalese:
                        '© 2026 AH Store. All rights reserved.',
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                'AH Store',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 5),

            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SETTINGS CARD
  // ============================================================

  Widget _buildSettingsCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: child,
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _buildDivider() {
    return const Divider(
      color: borderColor,
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}