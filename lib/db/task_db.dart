import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/task.dart';

class TaskDatabase {
  String tableRecentTasks = 'tasks';
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("Create task db");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableRecentTasks ( 
      text $textType,
      completed $idType
      )
    '''); //0 not complete/ 1 completed
  }

  /////Recent search//////////////
  Future<TaskModel> create(TaskModel taskModel) async {
    final db = await instance.database;
    final id = await db.insert(tableRecentTasks, taskModel.toJson());
    return taskModel;
  }

  Future<List<TaskModel>> readTasks() async {
    final db = await instance.database;

    final result = await db.query(
      tableRecentTasks,
    );

    return result.map((json) => TaskModel.fromJson(json)).toList();
  }

  insert(List<TaskModel> tasks) async {
    final db = await instance.database;
    Batch batch = db.batch();

    tasks.forEach((task) {
      batch.insert(tableRecentTasks, task.toJson());
    });

    batch.commit();
  }

  // Future<int> update(TaskModel taskModel) async {
  //   final db = await instance.database;

  //   return db.update(
  //     tableRecentTasks,
  //     taskModel.toJson(),
  //     where: 'id = ?',
  //     whereArgs: [taskModel.id],
  //   );
  // }

}
