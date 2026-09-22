import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  // ============================================================
  // COLORS
  // ============================================================

  static const Color backgroundColor = Color(0xFF080705);
  static const Color goldColor = Color(0xFFB89532);
  static const Color cardColor = Color(0xFF12110F);
  static const Color borderColor = Color(0xFF2D2A25);
  static const Color secondaryTextColor = Color(0xFF9D9991);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // ============================================================
      // APP BAR
      // ============================================================

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
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ======================================================
            // HEADER CARD
            // ======================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.shield_outlined,
                    color: goldColor,
                    size: 48,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'AH STORE',
                    style: TextStyle(
                      color: goldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Learn how AH STORE handles your information '
                    'and account data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ======================================================
            // 1. INFORMATION WE COLLECT
            // ======================================================

            _buildSection(
              number: '1',
              title: 'Information We Collect',
              content:
                  'AH STORE may collect basic account information '
                  'provided by you, such as your name, email address, '
                  'contact information, and account-related details. '
                  'This information is used to provide and manage '
                  'your account and shopping experience.',
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 2. HOW WE USE YOUR INFORMATION
            // ======================================================

            _buildSection(
              number: '2',
              title: 'How We Use Your Information',
              content:
                  'Your information may be used to manage your account, '
                  'provide app features, improve the AH STORE experience, '
                  'process your requests, and provide customer support.',
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 3. DATA STORAGE
            // ======================================================

            _buildSection(
              number: '3',
              title: 'Data Storage',
              content:
                  'AH STORE uses Firebase services for authentication '
                  'and storing application data. Account information and '
                  'other app-related data are stored using the configured '
                  'Firebase services.',
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 4. DATA SECURITY
            // ======================================================

            _buildSection(
              number: '4',
              title: 'Data Security',
              content:
                  'We take reasonable steps to protect account and '
                  'application data. Users should also keep their '
                  'password confidential and avoid sharing their '
                  'account credentials with others.',
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 5. SHARING OF INFORMATION
            // ======================================================

            _buildSection(
              number: '5',
              title: 'Sharing of Information',
              content:
                  'AH STORE does not intentionally sell your personal '
                  'account information. Information may be processed '
                  'through services required to operate the application, '
                  'such as Firebase.',
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 6. YOUR ACCOUNT
            // ======================================================

            _buildSection(
              number: '6',
              title: 'Your Account',
              content:
                  'You are responsible for maintaining the security '
                  'of your account credentials. You can manage certain '
                  'account settings through the Settings section of '
                  'the AH STORE application.',
            ),

            const SizedBox(height: 20),

            // ======================================================
            // 7. POLICY UPDATES
            // ======================================================

            _buildSection(
              number: '7',
              title: 'Policy Updates',
              content:
                  'This Privacy Policy may be updated when necessary '
                  'to reflect changes in the AH STORE application or '
                  'its services. Updated information will be provided '
                  'within the application when appropriate.',
            ),

            const SizedBox(height: 30),

            // ======================================================
            // FOOTER
            // ======================================================

            Center(
              child: Column(
                children: const [
                  Text(
                    'AH Store',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION WIDGET
  // ============================================================

  static Widget _buildSection({
    required String number,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: goldColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: goldColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: goldColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            content,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}