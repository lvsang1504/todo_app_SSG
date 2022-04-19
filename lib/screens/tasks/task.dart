import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/task.dart';
import 'dart:math' as math;
import '../../models/todo_list.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  TextStyle _taskStyle(completed) {
    if (completed) {
      return const TextStyle(
          color: Colors.black54,
          decoration: TextDecoration.lineThrough,
          fontWeight: FontWeight.bold,
          fontSize: 20);
    } else {
      return const TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          fontSize: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<TaskModel>(builder: (context, task, child) {
        return Container(
          decoration: BoxDecoration(
              color: task.completed ? Colors.white : Colors.black12,
              borderRadius: BorderRadius.circular(8)),
          child: CheckboxListTile(
            title: Text(
              task.text,
              style: _taskStyle(task.completed),
            ),
            activeColor: Colors.black87,
            value: task.completed,
            onChanged: (newValue) {
              task.toggle();
              Provider.of<TodoListModel>(context, listen: false)
                  .saveTasksToSharedPrefs(task);
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );
      }),
    );
  }
}
