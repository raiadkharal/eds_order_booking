import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:order_booking/components/button/cutom_button.dart';
import 'package:order_booking/ui/sample.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:signature/signature.dart';

import '../../utils/utils.dart';

class CustomerInputScreen extends StatefulWidget {
  const CustomerInputScreen({super.key});

  @override
  State<CustomerInputScreen> createState() => _CustomerInputScreenState();
}

class _CustomerInputScreenState extends State<CustomerInputScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2, // Adjust the stroke width as needed
    penColor: Colors.black, // Adjust the pen color as needed
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text("EDS"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "OutletName: ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Text(
                                      "",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "Order Amount: ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Text(
                                      "0.0",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "Customer CNIC: ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: TextField(
                                      style: GoogleFonts.roboto(fontSize: 14),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                        hintText: "13 digits CNIC",
                                        hintStyle:
                                            GoogleFonts.roboto(fontSize: 14),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "Customer STRN: ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: TextField(
                                      style: GoogleFonts.roboto(fontSize: 14),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                        hintText:
                                            "Sales tax registration number",
                                        hintStyle:
                                            GoogleFonts.roboto(fontSize: 14),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "Mobile No. for Order: ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: TextField(
                                      style: GoogleFonts.roboto(fontSize: 14),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                        hintText: "03XXXXXXXXX",
                                        hintStyle:
                                            GoogleFonts.roboto(fontSize: 14),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      "Delivery Date: ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: InkWell(
                                      onTap: () async{
                                        final selectedDate = await selectDeliveryDate();
                                        showToastMessage(selectedDate??"");
                                      },
                                      child: TextField(
                                        style: GoogleFonts.roboto(fontSize: 14),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabled: false,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                          hintText: "1/01/2024",
                                          hintStyle:
                                              GoogleFonts.roboto(fontSize: 14),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade600)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade600)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5.0, bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Remarks: ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      style: GoogleFonts.roboto(fontSize: 14),
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                        hintText: "Type Remarks Here",
                                        hintStyle:
                                            GoogleFonts.roboto(fontSize: 14),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade600)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Customer Signature",
                                    style: GoogleFonts.roboto(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                  MaterialButton(
                                    color: Colors.grey,
                                    child: Text(
                                      "Clear Signature",
                                      style: GoogleFonts.roboto(
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _controller.clear();
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                child: Signature(
                                  height: 150,
                                  controller: _controller,
                                  backgroundColor: Colors
                                      .white, // Adjust the background color as needed
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CustomButton(onTap: () {}, text: "Next")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> selectDeliveryDate() async {

    try {
      //show date picker dialog to user
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 0)),
          lastDate: DateTime(2101));

      // Convert selectedDate to String using intl package
      if (pickedDate != null) {
        return DateFormat('MM/dd/yyyy').format(pickedDate);
      }
    } catch (e) {
      showToastMessage("Something went wrong. Please try again later");
    }
    return null;
  }
}
