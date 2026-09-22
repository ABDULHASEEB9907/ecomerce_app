import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import 'login_screen.dart';
import 'personal_information_screen.dart';
import 'help_support.dart';
import 'setting.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();

  String fullName = 'User';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await _authService.getUserData();

      if (!mounted) return;

      if (userData != null) {
        setState(() {
          fullName = userData.fullName;
          email = userData.email;
        });
      }
    } catch (e) {
      // Keep default profile information if data cannot be loaded.
    }
  }

  Future<void> _logout() async {
    await _authService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  void _showComingSoon(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF080705);
    const Color goldColor = Color(0xFFB89532);
    const Color cardColor = Color(0xFF12110F);
    const Color borderColor = Color(0xFF2D2A25);
    const Color secondaryTextColor = Color(0xFF9D9991);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'My Profile',
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
            // PROFILE HEADER
            // ============================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Row(
                children: [

                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: goldColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: goldColor,
                        width: 1.2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: goldColor,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (email.isNotEmpty) ...[
                          const SizedBox(height: 5),
                          Text(
                            email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: secondaryTextColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ============================================================
            // ACCOUNT
            // ============================================================

            const Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 10,
              ),
              child: Text(
                'Account',
                style: TextStyle(
                  color: goldColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Column(
                children: [

                  // Personal Information
                  _buildProfileTile(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    subtitle: 'Manage your personal information',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PersonalInformationScreen(),
                        ),
                      );
                    },
                  ),

                  _buildDivider(),

                  // Wishlist
                  _buildProfileTile(
                    icon: Icons.favorite_border,
                    title: 'Wishlist',
                    subtitle: 'View your saved products',
                    onTap: () {
                      _showComingSoon(
                        'Wishlist will be available soon.',
                      );
                    },
                  ),

                  _buildDivider(),

                  // My Orders
                  _buildProfileTile(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    subtitle: 'View your order history',
                    onTap: () {
                      _showComingSoon(
                        'My Orders will be available soon.',
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ============================================================
            // MORE
            // ============================================================

            const Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 10,
              ),
              child: Text(
                'More',
                style: TextStyle(
                  color: goldColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Column(
                children: [

                  // ======================================================
                  // SETTINGS - LINKED
                  // ======================================================

                  _buildProfileTile(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    subtitle: 'Manage your app preferences',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SettingsScreen(),
                        ),
                      );
                    },
                  ),

                  _buildDivider(),

                  // Help & Support
                  _buildProfileTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'Get help with your account',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HelpSupportScreen(),
                        ),
                      );
                    },
                  ),

                  _buildDivider(),

                  // Logout
                  _buildProfileTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    subtitle: 'Sign out from your account',
                    iconColor: goldColor,
                    onTap: _logout,
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
  // PROFILE TILE
  // ============================================================

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFFB89532),
  }) {
    const Color secondaryTextColor = Color(0xFF9D9991);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 7,
      ),
      leading: Icon(
        icon,
        color: iconColor,
        size: 25,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: secondaryTextColor,
          fontSize: 13,
        ),
      ),
      trailing: title == 'Logout'
          ? null
          : const Icon(
              Icons.chevron_right,
              color: secondaryTextColor,
            ),
      onTap: onTap,
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _buildDivider() {
    const Color borderColor = Color(0xFF2D2A25);

    return const Divider(
      color: borderColor,
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    );
  }
}