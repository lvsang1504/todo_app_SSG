import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/todo_list.dart';

void main() {
  test('Add a task to the todolist', () {
    final todoList = TodoListModel();
    expect(todoList.tasks.length, 0);
    final task = TaskModel(text: "task 1");
    todoList.addTaks(task);
    expect(todoList.tasks.length, 1);
  });

  test('save and get todolist in shared preferences', () async {
    // create and save a todolist
    final todoList = TodoListModel();
    final task = TaskModel(text: "task 22", completed: false);
    
    todoList.addTaks(task);
    await todoList.saveTasksToSharedPrefs(task);

    // get tasks from shared preferences
    final todoList2 = TodoListModel();
    await todoList2.getTasksFromSharedPrefs();
    expect(todoList2.tasks.length, 3);
  });
}
