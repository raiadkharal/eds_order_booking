import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (tasks != null && tasks.isNotEmpty) {
            for (Task task in tasks) {
              batch.insert("Tasks", task.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
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

  @override
  Future<void> updateTask(Task taskParam) async {
    try {
      _database.update("Tasks", taskParam.toJson(),
          where: "taskId = ? and taskTypeId = ?",
          whereArgs: [taskParam.taskId, taskParam.taskTypeId]);
    } catch (e) {
      e.printInfo();
    }
  }
}
