import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/order/order_booking_list_item.dart';
import 'package:order_booking/ui/task/pending_task_list_item.dart';

import '../../components/button/cutom_button.dart';
import '../../utils/Colors.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({super.key});

  @override
  State<PendingTaskScreen> createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "EDS",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return const PendingTaskListItem();
                  },
                  separatorBuilder: (context, index) {
                    return Container(color: Colors.grey,height: 0.5,);
                  },
                  itemCount: 10,
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomButton(onTap: () {}, text: "Next"),
          )
        ],
      ),
    );
  }
}
