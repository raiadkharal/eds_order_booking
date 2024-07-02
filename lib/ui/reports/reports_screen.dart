import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/Constants.dart';

import '../../utils/Colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Expanded(
              child: Text(
            "EDS",
            style: GoogleFonts.roboto(color: Colors.white),
          ))),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Routes",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),


            // outlets counts by their statuses

            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 31,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          Constants.reportTopSummaryTitles[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "0",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: 5,
              ),
            ),

            //completion rate section

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 31,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          Constants.reportTopSummaryTitles2[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          index == 0 ? "0 %" : "0",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),

            //performance section

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 31,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          Constants.reportTopSummaryTitles3[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles3.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          index == 0 ? "0 %" : "0",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),


            // carton and total amount section


            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    "Carton(s)",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Total Amount",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "0",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Rs 00.00",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            //Confirmed Orders section


            const SizedBox(
              height: 20,
            ),
            Text(
              "Confirmed Orders:",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 34,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          Constants.reportQuantityTitles[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportQuantityTitles.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          index == 0 ? "0 (0)" : "RS 00.00",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
