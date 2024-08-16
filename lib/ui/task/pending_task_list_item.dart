import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/task/task.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:order_booking/utils/Constants.dart';

class PendingTaskListItem extends StatelessWidget {
  final Task task;
  final Function(Task) onClick;

  const PendingTaskListItem(
      {super.key, required this.task, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(task),
      child: Card(
        elevation: 1,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: Colors.white,
        child: ListTile(
          leading: const Image(
            image: AssetImage("assets/images/task_icon.png"),
            color: secondaryColor,
            colorBlendMode: BlendMode.dstIn,
          ),
          title: Text(
            task.taskName ?? "",
            style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            task.taskDate ?? "",
            style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.normal),
          ),
          trailing: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  color:
                      task.status?.toUpperCase() == Constants.taskStatusList[0]
                          ? secondaryColor
                          : (task.status?.toUpperCase() ==
                                  Constants.taskStatusList[1]
                              ? Colors.green
                              : Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Text(
                      task.status?.toUpperCase() ?? "",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
