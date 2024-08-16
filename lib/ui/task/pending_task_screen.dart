import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/order/order_booking_list_item.dart';
import 'package:order_booking/ui/task/pending_task_list_item.dart';
import 'package:order_booking/ui/task/pending_task_view_model.dart';
import 'package:order_booking/ui/task/task_status_dialog.dart';

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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            child: CustomButton(
                onTap: () async {
                  final result = await Get.toNamed(EdsRoutes.orderBooking,
                      arguments: [outletId]);
                  if (result != null) {
                    Get.back(result: result);
                  }
                },
                text: "Next"),
          )
        ],
      ),
    );
  }
}
