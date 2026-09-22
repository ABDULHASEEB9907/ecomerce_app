import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ============================================================
  // SIGN UP
  // ============================================================

  Future<UserModel?> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // Firebase Authentication mein account create
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Firebase Authentication ki unique UID
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('User account could not be created.');
      }

      final String uid = firebaseUser.uid;

      // User Model
      final UserModel userModel = UserModel(
        uid: uid,
        fullName: fullName.trim(),
        email: email.trim(),
      );

      // ========================================================
      // FIRESTORE USERS COLLECTION
      // users
      //    └── UID
      //         ├── uid
      //         ├── fullName
      //         └── email
      // ========================================================

      await _firestore
          .collection('users')
          .doc(uid)
          .set(userModel.toMap());

      print('========================================');
      print('USER ACCOUNT CREATED SUCCESSFULLY');
      print('UID: $uid');
      print('Full Name: ${userModel.fullName}');
      print('Email: ${userModel.email}');
      print('Firestore document saved successfully.');
      print('========================================');

      return userModel;
    } on FirebaseAuthException catch (e) {
      print('Firebase Authentication Error: ${e.code}');
      print('Message: ${e.message}');
      rethrow;
    } on FirebaseException catch (e) {
      print('Firestore Error: ${e.code}');
      print('Message: ${e.message}');
      print('Plugin: ${e.plugin}');
      rethrow;
    } catch (e) {
      print('General Error: $e');
      rethrow;
    }
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('Login Error: ${e.code}');
      print('Message: ${e.message}');
      rethrow;
    }
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> logout() async {
    await _auth.signOut();
  }

  // ============================================================
  // CURRENT USER
  // ============================================================

  User? get currentUser {
    return _auth.currentUser;
  }

  // ============================================================
  // GET USER DATA FROM FIRESTORE
  // ============================================================

  Future<UserModel?> getUserData() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    final DocumentSnapshot<Map<String, dynamic>> document =
        await _firestore.collection('users').doc(user.uid).get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return UserModel.fromMap(document.data()!);
  }
}