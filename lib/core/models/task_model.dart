

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String taskId;
  final String taskName;
  final int status;
  final DocumentReference? reference;
  final DateTime createdDate;
  TaskModel({
    required this.taskId,
    required this.taskName,
    required this.status,
    this.reference,
    required this.createdDate,
  });

  TaskModel copyWith({
    String? taskId,
    String? taskName,
    int? status,
    DocumentReference? reference,
    DateTime? createdDate,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'taskName': taskName,
      'status': status,
      'reference': reference,
      'createdDate': createdDate,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        taskId: map['taskId'] ?? '',
        taskName: map['taskName'] ?? '',
        status: map['status'] ?? 0,
        reference: map['reference'],
        createdDate: map['createdDate'] == null
            ? DateTime.now()
            : map['createdDate'].toDate());
  }
}
