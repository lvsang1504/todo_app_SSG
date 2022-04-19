import 'package:to_do_app/db/task_db.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/repositories/task_repository_iml.dart';

class TaskRepository implements ITaskRepository {
  TaskDatabase _db;

  TaskRepository(this._db);

  @override
  Future<List<TaskModel>> getAll() async {
    return await _db.readTasks();
  }

  @override
  Future<TaskModel> insert(TaskModel taskModel) async {
    return await _db.create(taskModel);
  }
}
