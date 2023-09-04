import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_fire/model/todo_model.dart';

class ToDoService {
  final todoCollection = FirebaseFirestore.instance.collection('taskApp');

  // Create
  void addNewTask(TodoModel todoModel) {
    todoCollection.add(todoModel.toMap());
  }

  //Update
  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update(
      {'isDone': valueUpdate},
    );
  }

  //Delete
  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
