import 'package:order_booking/db/entities/task/task.dart';

abstract class TaskDao {
  Future<void> deleteAllTask();

  Future<void> insertTasks(List<Task>? tasks);

  Future<List<Task>?> getTaskByOutletId(int outletId);

  Future<void> updateTask(Task taskParam);
}