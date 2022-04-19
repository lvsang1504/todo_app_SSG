import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo_list.dart';

class CompletedTasks extends StatelessWidget {
  final TodoListModel todoList;

  CompletedTasks({required this.todoList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed tasks'),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: ListView(
            children: todoList.getCompletedTasks().map((t) {
          return GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Center(child:  Text('Task')),
                      content: Text(t.text),
                    )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          t.text,
                          style: const TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList()));
  }
}
