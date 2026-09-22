import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/report_model.dart';

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> submitReport({
    required String title,
    required String email,
    required String description,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    final ReportModel report = ReportModel(
      userId: user.uid,
      title: title.trim(),
      email: email.trim(),
      description: description.trim(),
      createdAt: Timestamp.now(),
    );

    await _firestore.collection('reports').add(
          report.toMap(),
        );
  }
}