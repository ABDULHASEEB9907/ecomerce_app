import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatefulWidget {
  final bool isGuest;

  const PersonalInformationScreen({
    super.key,
    this.isGuest = false,
  });

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  // ============================================================
  // FIREBASE
  // ============================================================

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  String fullName = '';
  String email = '';

  bool isLoading = true;

  // ============================================================
  // AH STORE THEME
  // ============================================================

  static const Color background = Color(0xFF080705);
  static const Color card = Color(0xFF11100D);
  static const Color imageBackground = Color(0xFF171613);
  static const Color border = Color(0xFF3D3728);

  static const Color gold = Color(0xFFC5A33D);
  static const Color lightGold = Color(0xFFD2B24C);

  static const Color white = Color(0xFFF5F2EA);
  static const Color grey = Color(0xFF8D8981);

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();
    _loadUserInformation();
  }

  // ============================================================
  // LOAD CURRENT LOGGED-IN USER
  // ============================================================

  Future<void> _loadUserInformation() async {
    if (widget.isGuest) {
      if (!mounted) return;

      setState(() {
        fullName = 'Guest User';
        email = 'Guest Account (Not Signed In)';
        isLoading = false;
      });

      return;
    }

    try {
      // ----------------------------------------------------------
      // Get currently logged-in Firebase user
      // ----------------------------------------------------------

      final User? currentUser = _auth.currentUser;

      // ----------------------------------------------------------
      // No user logged in
      // ----------------------------------------------------------

      if (currentUser == null) {
        if (!mounted) return;

        setState(() {
          fullName = 'Guest User';
          email = '';
          isLoading = false;
        });

        return;
      }

      // ----------------------------------------------------------
      // Get THIS user's Firestore document
      //
      // users
      //   └── currentUser.uid
      //        ├── uid
      //        ├── fullName
      //        └── email
      // ----------------------------------------------------------

      final DocumentSnapshot<Map<String, dynamic>> userDocument =
          await _firestore
              .collection('users')
              .doc(currentUser.uid)
              .get();

      String firestoreName = '';
      String firestoreEmail = '';

      if (userDocument.exists) {
        final Map<String, dynamic>? data =
            userDocument.data();

        if (data != null) {
          // IMPORTANT:
          // Signup ke waqt naam "fullName" field mein save hota hai.
          firestoreName =
              (data['fullName'] ?? '').toString().trim();

          firestoreEmail =
              (data['email'] ?? '').toString().trim();
        }
      }

      // ----------------------------------------------------------
      // Show user information
      // ----------------------------------------------------------

      if (!mounted) return;

      setState(() {
        // Firestore Full Name first
        // Firebase Auth displayName second
        fullName = firestoreName.isNotEmpty
            ? firestoreName
            : (currentUser.displayName ?? '').trim();

        // Firestore email first
        // Firebase Auth email second
        email = firestoreEmail.isNotEmpty
            ? firestoreEmail
            : (currentUser.email ?? '').trim();

        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to load profile information.',
          ),
        ),
      );
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: lightGold,
            size: 20,
          ),
        ),

        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth =
                constraints.maxWidth;

            final double contentWidth =
                screenWidth > 430 ? 430 : screenWidth;

            return Center(
              child: SizedBox(
                width: contentWidth,

                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: gold,
                        ),
                      )
                    : SingleChildScrollView(
                        physics:
                            const BouncingScrollPhysics(),

                        padding:
                            const EdgeInsets.fromLTRB(
                          14,
                          20,
                          14,
                          30,
                        ),

                        child: Column(
                          children: [
                            // ==================================
                            // PROFILE ICON
                            // ==================================

                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: imageBackground,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: gold,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                color: lightGold,
                                size: 42,
                              ),
                            ),

                            const SizedBox(height: 30),

                            // ==================================
                            // FULL NAME
                            // ==================================

                            _informationCard(
                              icon: Icons
                                  .person_outline_rounded,
                              title: 'Full Name',
                              value: fullName.isNotEmpty
                                  ? fullName
                                  : 'Name not available',
                            ),

                            const SizedBox(height: 8),

                            // ==================================
                            // EMAIL
                            // ==================================

                            _informationCard(
                              icon: Icons.email_outlined,
                              title: 'Email Address',
                              value: email.isNotEmpty
                                  ? email
                                  : 'Email not available',
                            ),

                            const SizedBox(height: 22),

                            // ==================================
                            // EDIT PROFILE
                            // ==================================

                            SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: GestureDetector(
                                onTap: () {
                                  if (widget.isGuest) {
                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please log in to edit your profile.',
                                        ),
                                      ),
                                    );

                                    return;
                                  }

                                  ScaffoldMessenger.of(
                                          context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Edit Profile feature will be available soon.',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration:
                                      BoxDecoration(
                                    color: gold,
                                    borderRadius:
                                        BorderRadius.circular(
                                            9),
                                  ),
                                  alignment:
                                      Alignment.center,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit_outlined,
                                        color: background,
                                        size: 17,
                                      ),

                                      SizedBox(width: 8),

                                      Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                          color: background,
                                          fontSize: 10,
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // INFORMATION CARD
  // ============================================================

  Widget _informationCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: border,
          width: 0.8,
        ),
      ),

      child: Row(
        children: [
          // ================================================
          // ICON
          // ================================================

          Container(
            width: 36,
            height: 36,

            decoration: BoxDecoration(
              color: imageBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: border,
                width: 0.7,
              ),
            ),

            child: Icon(
              icon,
              color: lightGold,
              size: 18,
            ),
          ),

          const SizedBox(width: 11),

          // ================================================
          // TEXT
          // ================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: grey,
                    fontSize: 8,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
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