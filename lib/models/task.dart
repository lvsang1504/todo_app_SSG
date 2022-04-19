import 'package:flutter/foundation.dart';

class TaskModel extends ChangeNotifier {
  final String text;
  bool completed;

  TaskModel({required this.text, this.completed = false});

  TaskModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        completed = json['completed'] == 0 ? false : true;

  Map<String, dynamic> toJson() =>
      {'text': text, 'completed': completed ? 1 : 0};

  TaskModel copy({String? text, bool? completed}) => TaskModel(
        text: text!,
        completed: completed!,
      );

  void toggle() {
    completed = !completed;
    notifyListeners();
  }
}
