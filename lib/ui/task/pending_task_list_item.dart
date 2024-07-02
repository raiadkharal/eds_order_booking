import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/Colors.dart';

class PendingTaskListItem extends StatelessWidget {
  const PendingTaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Image(
        image: AssetImage("assets/images/task_icon.png"),
        color: secondaryColor,
        colorBlendMode: BlendMode.dstIn,
      ),
      title: Text(
        "Task name",
        style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        "May 17, 2024",
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
              color: secondaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 2),
                child: Text(
                  "PENDING",
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
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
    );
  }
}
