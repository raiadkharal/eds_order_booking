import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const LogoutConfirmationDialog(
      {super.key, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      insetPadding: const EdgeInsets.all(20),
      title: Text(
        "Logout!",
        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Are you sure you want to logout?",
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: onCancel,
                    child: Text(
                      "No",
                      style: GoogleFonts.roboto(color: Colors.black,fontSize: 16),
                    )),
                TextButton(
                    onPressed: onConfirm,
                    child: Text(
                      "Yes",
                      style: GoogleFonts.roboto(color: Colors.black,fontSize: 16),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
