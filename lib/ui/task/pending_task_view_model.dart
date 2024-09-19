import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/route/outlet/merchandising/merchandising_view_model.dart';
import 'package:order_booking/utils/Constants.dart';

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
      DateTime currentDate = DateTime.now();
      // Define the date format
      DateFormat dateFormat = DateFormat('MM/dd/yyyy');
      taskParam.completedDate=dateFormat.format(currentDate);
     taskList[index]=taskParam;
     taskList.refresh();
     // _statusRepository.updateTask(taskParam);
    } else {
      if (kDebugMode) {
        print('Task with id ${taskParam.taskId} not found.');
      }
    }
  }

  bool hasPendingTasksWithLastDate() {
    for (int i = 0; i < taskList.length; i++) {
      Task task = taskList[i];
      if (isDateEqualToCurrentDate(task.taskDate)&&task.status==Constants.taskStatusList[0]) {
        return true;
      }
    }
    return false;
  }


  bool isDateEqualToCurrentDate(String? taskDate) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Define the date format
    DateFormat dateFormat = DateFormat('MM/dd/yyyy');

    try {
      // Format the current date as a string
      String currentDateStr = dateFormat.format(currentDate);

      // Check if the taskDate is equal to the current date
      if (taskDate != null && taskDate == currentDateStr) {
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }

    return false;
  }

  void deleteTaskByOutletId(int outletId) {
    _statusRepository.deleteTaskByOutletId(outletId);
  }

  void insertTasks() {
    _statusRepository.insertTasks(taskList);
  }


}