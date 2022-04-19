import 'package:to_do_app/models/task.dart';

abstract class ITaskRepository {
  Future<List<TaskModel>> getAll();
  Future<TaskModel> insert(TaskModel taskModel);
}
