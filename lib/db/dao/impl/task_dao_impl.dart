import 'package:order_booking/db/dao/task_dao.dart';
import 'package:order_booking/db/entities/task/task.dart';
import 'package:sqflite/sqflite.dart';

class TaskDaoImpl extends TaskDao {
  final Database _database;

  TaskDaoImpl(this._database);

  @override
  Future<void> deleteAllTask() async {
    _database.rawQuery("DELETE FROM Tasks");
  }

  @override
  Future<void> insertTasks(List<Task>? tasks) async {
    if (tasks != null) {
      for (Task task in tasks) {
        _database.insert("Tasks", task.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<List<Task>?> getTaskByOutletId(int outletId) async {
    final result = await _database
        .query("Tasks", where: "outletId = ?", whereArgs: [outletId]);

    return result
        .map(
          (e) => Task.fromJson(e),
        )
        .toList();
  }
}
