import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/todo_list.dart';

import 'task.dart';

class TodoListWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: Consumer<TodoListModel>(builder: (context, tasks, child) {
        return ListView(
          children: tasks.tasks.map((TaskModel task) {
            return ChangeNotifierProvider.value(
                value: task, child: const TaskWidget());
          }).toList(),
        );
      })),
      Consumer<TodoListModel>(
        builder: (context, tasks, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  labelText: 'Add new tasks',
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (_controller.text.isEmpty) {
                          final snackBar = SnackBar(
                            content: const Text('Content empty!'),
                            action: SnackBarAction(
                              label: 'Fail',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          tasks.addTaks(TaskModel(text: _controller.text));
                          _controller.clear();
                          tasks.saveTasksToSharedPrefs(TaskModel(text: _controller.text));
                        }
                      },
                      icon: const Icon(Icons.add))),
              onSubmitted: (newTask) {
                tasks.addTaks(TaskModel(text: newTask));
                _controller.clear();
                tasks.saveTasksToSharedPrefs(TaskModel(text: newTask));
              },
            ),
          );
        },
      )
    ]);
  }
}
