import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/order/order_booking_list_item.dart';
import 'package:order_booking/ui/task/pending_task_list_item.dart';
import 'package:order_booking/ui/task/pending_task_view_model.dart';
import 'package:order_booking/ui/task/task_status_dialog.dart';
import 'package:order_booking/utils/Constants.dart';

import '../../components/button/cutom_button.dart';
import '../../db/entities/task/task.dart';
import '../../route.dart';
import '../../utils/Colors.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  final PendingTaskViewModel _controller =
      Get.put(PendingTaskViewModel(Get.find()));

  late final int outletId;

  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      outletId = args[0];
    } else {
      outletId = 0;
    }
    _controller.loadOutlet(outletId);
    _controller.loadTasks(outletId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "Pending Tasks",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            color: Colors.white,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "OutletName: ",
                      style:
                          GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 10,
                    child: Obx(
                      () => Text(
                        "${_controller.outlet.value.outletName}-${_controller.outlet.value.location}",
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.grey.shade600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemBuilder: (context, index) {
                return PendingTaskListItem(
                  task: _controller.taskList[index],
                  onClick: (Task task) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        insetPadding: const EdgeInsets.all(20),
                        content: TaskStatusDialog(
                          task: task,
                          onSave: (task) {
                            _controller.updateTask(task);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount: _controller.taskList.length,
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomButton(onTap: () => _onNextClick(), text: "Next"),
          )
        ],
      ),
    );
  }

  void _onNextClick() {
    if (_controller.hasPendingTasksWithLastDate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.all(20),
          title: Text(
            "Warning..",
            style: GoogleFonts.roboto(),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("You have pending tasks with last date to complete . Do you still want to continue?",style: GoogleFonts.roboto(),),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //negative button
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.roboto(
                              color: secondaryColor, fontSize: 16),
                        )),

                    //positive button
                    TextButton(
                        onPressed: () {
                          //insert task into database
                          insertTaskInToDb();

                          Navigator.of(context).pop();

                          //navigate to the Order Booking screen
                          Get.toNamed(EdsRoutes.orderBooking, arguments: [outletId])?.then(
                                (result) {
                              if (result != null && result[Constants.STATUS_OK]) {
                                Get.back(result: result);
                              }
                            },
                          );

                        },
                        child: Text(
                          "Yes",
                          style: GoogleFonts.roboto(
                              color: secondaryColor, fontSize: 16),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {
      //insert task into database
      insertTaskInToDb();
      //navigate to the Order Booking screen
      Get.toNamed(EdsRoutes.orderBooking, arguments: [outletId])?.then(
        (result) {
          if (result != null && result[Constants.STATUS_OK]) {
            Get.back(result: result);
          }
        },
      );
    }
  }


  void insertTaskInToDb() {
    _controller.deleteTaskByOutletId(outletId);
    _controller.insertTasks();
  }
}
