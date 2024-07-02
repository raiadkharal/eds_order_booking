import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/market_return/market_return_list_item.dart';
import 'package:order_booking/ui/market_return/return_item_dialog/return_item_dialog.dart';

import '../../utils/Colors.dart';

class MarketReturnScreen extends StatefulWidget {
  const MarketReturnScreen({super.key});

  @override
  State<MarketReturnScreen> createState() => _MarketReturnScreenState();
}

class _MarketReturnScreenState extends State<MarketReturnScreen> {
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              elevation: 3,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "PRODUCT:",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Product Name",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const ReturnItemDialog(),
                          );
                        },
                        icon: const Icon(
                          Icons.add_box,
                          size: 40,
                          color: secondaryColor,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return const MarketReturnListItem();
                },
                itemCount: 10),
          )
        ],
      ),
    );
  }
}
