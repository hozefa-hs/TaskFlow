import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/db_helper.dart';
import '../models/task_model.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    state = await DBHelper.getAllTasks();
  }

  Future<void> addTask(Task task) async {
    await DBHelper.insertTask(task);
    fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await DBHelper.updateTask(task);
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await DBHelper.deleteTask(id);
    fetchTasks();
  }
}
