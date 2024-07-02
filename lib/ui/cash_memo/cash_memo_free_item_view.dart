import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/Colors.dart';

class CashMemoFreeItemView extends StatelessWidget {
  const CashMemoFreeItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: 55,
                    width: 1,
                  ),
                ),
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
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Ssrb-Mirinda".toUpperCase(),
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.add_box,
                            color: Colors.blueAccent,
                            size: 35,
                          ),
                          Icon(
                            FontAwesomeIcons.solidMinusSquare,
                            color: Colors.red,
                            size: 35,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("C/U"),
                  )],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ssrb-Mirinda: ".toUpperCase(),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
