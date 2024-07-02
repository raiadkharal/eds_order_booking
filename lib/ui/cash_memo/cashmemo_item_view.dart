import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/Colors.dart';

class CashMemoItemView extends StatelessWidget {
  const CashMemoItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: SizedBox(
                    width: 8,
                    height: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: secondaryColor),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    color: secondaryColor,
                    height: 40,
                    width: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:5.0),
                  child: SizedBox(
                    width: 8,
                    height: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: secondaryColor),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Ssrb-Mirinda".toUpperCase(),
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity: ",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "5",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          "Total: ",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "1005.0",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
