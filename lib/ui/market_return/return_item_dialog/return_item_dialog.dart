import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:order_booking/utils/utils.dart';

import '../../../utils/Constants.dart';

class ReturnItemDialog extends StatefulWidget {
  const ReturnItemDialog({super.key});

  @override
  State<ReturnItemDialog> createState() => _ReturnItemDialogState();
}

class _ReturnItemDialogState extends State<ReturnItemDialog> {
  final _returnQtyController = TextEditingController();
  final _replaceQtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Return Reason: ",
                    style:
                        GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                    child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.white),
                  child: DropdownButtonFormField(
                    onChanged: (value) {},
                    isDense: true,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    items: Constants.assetVerificationList
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
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Return Qty: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            maxLines: 1,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.number,
                            controller: _returnQtyController,
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.all(5),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Qty",
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Replace Product: ",
                    style:
                        GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                    child: Theme(
                      data:
                          Theme.of(context).copyWith(canvasColor: Colors.white),
                      child: DropdownButtonFormField(
                        onChanged: (value) {},
                        isDense: true,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        items: Constants.assetVerificationList
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
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Replace Qty: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            maxLines: 1,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.number,
                            controller: _replaceQtyController,
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 16),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.all(5),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Qty",
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.roboto(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        showToastMessage("save clicked");
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.roboto(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
