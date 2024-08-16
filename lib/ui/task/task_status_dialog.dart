import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:order_booking/utils/Constants.dart';

import '../../db/entities/task/task.dart';

class TaskStatusDialog extends StatefulWidget {
  final Task task;
  final Function(Task) onSave;
  const TaskStatusDialog({
    super.key,
    required this.task, required this.onSave,
  });

  @override
  State<TaskStatusDialog> createState() => _TaskStatusDialogState();
}

class _TaskStatusDialogState extends State<TaskStatusDialog> {
  final TextEditingController _remarksController = TextEditingController();

  String? selectedStatus;

  @override
  void initState() {
    _remarksController.text=widget.task.remarks??"";
    selectedStatus = widget.task.status?.toUpperCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.task.taskName ?? "",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Status: ",
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87),
              ),
              Expanded(
                child: DropdownButtonFormField(
                  onChanged: (value) {
                    selectedStatus=value;
                  },
                  isDense: true,
                  alignment: Alignment.center,
                  value: selectedStatus,
                  isExpanded: true,
                  selectedItemBuilder: (BuildContext context) {
                    return Constants.taskStatusList.map((String value) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            value,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ),
                      );
                    }).toList();
                  },
                  decoration: const InputDecoration(
                    enabled: true,
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  items: Constants.taskStatusList
                      .map(
                        (element) => DropdownMenuItem(
                            value: element,
                            child: Text(
                              element,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            )),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: GoogleFonts.roboto(fontSize: 14),
              maxLines: 3,
              controller: _remarksController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                hintText: "Type Remarks Here",
                hintStyle: GoogleFonts.roboto(fontSize: 14),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: secondaryColor),)),
                TextButton(onPressed: () {
                  widget.task.remarks=_remarksController.text.toString();
                  if (selectedStatus!=null) {
                    widget.task.status=selectedStatus;
                  }
                  widget.onSave(widget.task);
                  Navigator.pop(context);
                }, child: Text("Save",style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: secondaryColor),))
              ],
            ),
          )
        ],
      ),
    );
  }
}
