import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_fire/model/todo_model.dart';
import 'package:todo_app_fire/service/to_do_service.dart';

final serviceProvider = StateProvider<ToDoService>((ref) {
  return ToDoService();
});

final fetchSteamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('taskApp')
      .snapshots()
      .map((event) => event.docs
          .map((snapshots) => TodoModel.fromSnapshot(snapshots))
          .toList());
  yield* getData;
});
