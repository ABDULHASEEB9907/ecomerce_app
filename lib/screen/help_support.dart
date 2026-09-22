import 'package:flutter/material.dart';

import '../services/report_service.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const Color backgroundColor = Color(0xFF080705);
  static const Color goldColor = Color(0xFFB89532);
  static const Color fieldColor = Color(0xFF12110F);
  static const Color borderColor = Color(0xFF2D2A25);
  static const Color secondaryTextColor = Color(0xFF9D9991);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
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
          'Help & Support',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How can we help?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Find answers to common questions or contact us if you need further assistance.',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              _buildSupportTile(
                context: context,
                icon: Icons.help_outline_rounded,
                title: 'FAQs',
                subtitle: 'Find answers to frequently asked questions.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FAQsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              _buildSupportTile(
                context: context,
                icon: Icons.support_agent_rounded,
                title: 'Contact Support',
                subtitle: 'Get help from the AH Store support team.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactSupportScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              _buildSupportTile(
                context: context,
                icon: Icons.report_problem_outlined,
                title: 'Report a Problem',
                subtitle: 'Tell us about an issue you are experiencing.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportProblemScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: goldColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: goldColor,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: secondaryTextColor,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// FAQs SCREEN
// ============================================================

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  static const Color backgroundColor = Color(0xFF080705);
  static const Color goldColor = Color(0xFFB89532);
  static const Color fieldColor = Color(0xFF12110F);
  static const Color borderColor = Color(0xFF2D2A25);
  static const Color secondaryTextColor = Color(0xFF9D9991);

  static const List<Map<String, String>> faqs = [
    {
      'question': 'How do I create an account?',
      'answer':
          'Open the Sign Up screen and enter your full name, email address, and password. After creating your account, you can log in using your registered email and password.',
    },
    {
      'question': 'How do I update my profile information?',
      'answer':
          'Go to Profile and open Personal Information. From there, you can view and update the available profile information.',
    },
    {
      'question': 'How do I browse products?',
      'answer':
          'You can browse products from the Home screen and explore different categories to find products you are interested in.',
    },
    {
      'question': 'How do I search for a product?',
      'answer':
          'Use the search bar available on the Home screen or Category screen to search for products.',
    },
    {
      'question': 'How do I add a product to my wishlist?',
      'answer':
          'Wishlist functionality will be available as the feature is implemented in AH Store.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
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
          'FAQs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final Map<String, String> faq = faqs[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: fieldColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                iconColor: goldColor,
                collapsedIconColor: secondaryTextColor,
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 3,
                ),
                childrenPadding: const EdgeInsets.fromLTRB(
                  18,
                  0,
                  18,
                  18,
                ),
                title: Text(
                  faq['question']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      faq['answer']!,
                      style: const TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// CONTACT SUPPORT SCREEN
// ============================================================

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  static const Color backgroundColor = Color(0xFF080705);
  static const Color goldColor = Color(0xFFB89532);
  static const Color fieldColor = Color(0xFF12110F);
  static const Color borderColor = Color(0xFF2D2A25);
  static const Color secondaryTextColor = Color(0xFF9D9991);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
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
          'Contact Support',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need help?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Our support team is here to assist you with your AH Store experience.',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),

            _infoCard(
              icon: Icons.email_outlined,
              title: 'Email Support',
              value: 'Support email will be available soon.',
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.access_time_rounded,
              title: 'Support Hours',
              value: 'Monday – Saturday\n10:00 AM – 6:00 PM',
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.schedule_rounded,
              title: 'Response Time',
              value: 'We usually respond within 24–48 hours.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: goldColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: goldColor,
              size: 23,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REPORT PROBLEM SCREEN
// ============================================================

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  static const Color backgroundColor = Color(0xFF080705);
  static const Color goldColor = Color(0xFFB89532);
  static const Color fieldColor = Color(0xFF12110F);
  static const Color borderColor = Color(0xFF2D2A25);
  static const Color secondaryTextColor = Color(0xFF9D9991);

  final ReportService _reportService = ReportService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    titleController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    final String title = titleController.text.trim();
    final String email = emailController.text.trim();
    final String description = descriptionController.text.trim();

    if (title.isEmpty || email.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all fields.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _reportService.submitReport(
        title: title,
        email: email,
        description: description,
      );

      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      titleController.clear();
      emailController.clear();
      descriptionController.clear();

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: fieldColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(
                color: borderColor,
              ),
            ),
            title: const Text(
              'Report Submitted',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Your report has been submitted successfully. Thank you for helping us improve AH Store.',
              style: TextStyle(
                color: secondaryTextColor,
                height: 1.5,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: goldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to submit your report. Please try again later.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
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
          'Report a Problem',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us what went wrong',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please provide some details about the problem so we can improve AH Store.',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              _buildLabel('Problem Title'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: titleController,
                hintText: 'Enter problem title',
                icon: Icons.title_rounded,
              ),

              const SizedBox(height: 20),

              _buildLabel('Email Address'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: emailController,
                hintText: 'Enter your email address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              _buildLabel('Describe the Problem'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: descriptionController,
                hintText: 'Describe the problem you are experiencing',
                icon: Icons.description_outlined,
                maxLines: 6,
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldColor,
                    disabledBackgroundColor: goldColor.withOpacity(0.45),
                    foregroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 23,
                          height: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: backgroundColor,
                          ),
                        )
                      : const Text(
                          'Submit Report',
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
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      cursorColor: goldColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: secondaryTextColor,
          fontSize: 13,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            bottom: maxLines > 1 ? 65 : 0,
          ),
          child: Icon(
            icon,
            color: goldColor,
            size: 21,
          ),
        ),
        filled: true,
        fillColor: fieldColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: goldColor,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
