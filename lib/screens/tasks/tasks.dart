import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo_list.dart';

import '../completed_tasks/completed_tasks.dart';
import 'todolist.dart';

class Tasks extends StatelessWidget {
  void _goToCompletedTasks(context, todoList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompletedTasks(todoList: todoList)));
  }

  @override
  Widget build(BuildContext context) {
    final TodoListModel todoList = TodoListModel();
    todoList.getTasksFromSharedPrefs();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          centerTitle: true,
          backgroundColor: Colors.black87,
          actions: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle
              ),
              child: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () => _goToCompletedTasks(context, todoList),
              ),
            ),
          ],
        ),
        body: ChangeNotifierProvider.value(
          value: todoList,
          child: TodoListWidget(),
        ));
  }
}
