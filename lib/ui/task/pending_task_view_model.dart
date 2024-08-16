import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/route/outlet/merchandising/merchandising_view_model.dart';

import '../../db/entities/outlet/outlet.dart';
import '../../db/entities/task/task.dart';

class PendingTaskViewModel extends GetxController{
  final StatusRepository _statusRepository;

  PendingTaskViewModel(this._statusRepository);

  Rx<Outlet> outlet = Outlet().obs;
  RxList<Task> taskList = RxList();

  void loadOutlet(int outletId) {
    _statusRepository.findOutletById(outletId).then((value) {
      outlet(value);
    },);
  }

  void loadTasks(int outletId) {
    _statusRepository.getTasksByOutletId(outletId).then((tasks) {
      taskList(tasks);
      taskList.refresh();
    },);
  }

  void updateTask(Task taskParam) {
    // Find the index of the task with the given ID
    int index = taskList.indexWhere((task) => task.taskId == taskParam.taskId);

    if (index != -1) {
      // Update the task at the found index
     taskList[index]=taskParam;
     _statusRepository.updateTask(taskParam);
    } else {
      if (kDebugMode) {
        print('Task with id ${taskParam.taskId} not found.');
      }
    }
  }


}