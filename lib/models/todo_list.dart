import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/db/task_db.dart';
import 'dart:convert';

import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/repositories/task_repository.dart';

class TodoListModel extends ChangeNotifier {
  List<TaskModel> tasks = [];

  TaskRepository repository = TaskRepository(TaskDatabase.instance);

  void addTaks(TaskModel task) {
    tasks.add(task);
    notifyListeners();
  }

  Future<void> getTasksFromSharedPrefs() async {
    // final prefs = await SharedPreferences.getInstance();
    // final tasksJson = prefs.getString('tasks') ?? '[]';
    // final jsonListTasks = jsonDecode(tasksJson).cast<Map<String, dynamic>>();
    // tasks = jsonListTasks.map<TaskModel>((m) => TaskModel.fromJson(m)).toList();

    tasks = await repository.getAll();
    notifyListeners();
  }

  Future<void> saveTasksToSharedPrefs(TaskModel task) async {
    // final prefs = await SharedPreferences.getInstance();
    // final json = jsonEncode(tasks);
    // prefs.setString('tasks', json);
    repository.insert(task);
  }

  List<TaskModel> getCompletedTasks() {
    return tasks.where((t) => t.completed == true).toList();
  }
}
