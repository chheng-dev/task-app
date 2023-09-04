import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String titleTask;
  final String description;
  final String category;
  final String date;
  final String time;
  final bool isDone;

  TodoModel({
    this.docID,
    required this.titleTask,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docID': docID,
      'titleTask': titleTask,
      'description': description,
      'category': category,
      'date': date,
      'time': time,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleTask: map['titleTask'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docID: doc.id,
      titleTask: doc['titleTask'],
      description: doc['description'],
      category: doc['category'],
      date: doc['date'],
      time: doc['time'],
      isDone: doc['isDone']
    );
  }
}
