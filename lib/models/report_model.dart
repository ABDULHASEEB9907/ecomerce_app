import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String userId;
  final String title;
  final String email;
  final String description;
  final Timestamp createdAt;

  ReportModel({
    required this.userId,
    required this.title,
    required this.email,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'email': email,
      'description': description,
      'createdAt': createdAt,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      userId: (map['userId'] ?? '').toString(),
      title: (map['title'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
      createdAt: map['createdAt'] is Timestamp
          ? map['createdAt'] as Timestamp
          : Timestamp.now(),
    );
  }
}