import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/cash_memo/cash_memo_free_item_view.dart';
import 'package:order_booking/ui/cash_memo/cashmemo_item_view.dart';

import '../../components/button/cutom_button.dart';
import '../../utils/Colors.dart';
import '../../utils/Constants.dart';

class CashMemoScreen extends StatefulWidget {
  const CashMemoScreen({super.key});

  @override
  State<CashMemoScreen> createState() => _CashMemoScreenState();
}

class _CashMemoScreenState extends State<CashMemoScreen> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Outlet Name: ",
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "3040212542-1 shop: ",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                color: secondaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 7,
                        child: Text(
                          "Qty: 6000.0",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start,
                        )),
                    Expanded(
                        flex: 12,
                        child: Text(
                          "Free Qty: 0.0",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                        flex: 11,
                        child: Text(
                          "Total: 0.0",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.end,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return const CashMemoItemView();
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 0.5,
                        color: Colors.grey,
                      );
                    },
                    itemCount: 10)),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: MaterialButton(
                                            onPressed: () {},
                                            color: primaryColor,
                                            child: Text(
                        "Edit Order",
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                                            ),
                                          ),
                      )),
                  Expanded(
                      child: CustomButton(
                    onTap: () {},
                    text: "Next",
                    minWidth: 100,
                    horizontalPadding: 3,
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
