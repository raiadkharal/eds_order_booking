import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/reports/stock/stock_list_item.dart';

import '../../../components/button/cutom_button.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Constants.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left: 2, right: 2),
            child: Card(
              elevation: 3,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Routes",style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 2, right: 2),
            child: Card(
              elevation: 3,
              color: Colors.white,
              shape:
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Package Name: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    Expanded(
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(canvasColor: Colors.white),
                          child: DropdownButtonFormField(
                            onChanged: (value) {},
                            isDense: true,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.all(5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
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
                                        color: Colors.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            )
                                .toList(),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Card(
              elevation: 3,
              color: secondaryColor,
              shape:
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Name",
                          style: GoogleFonts.roboto(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Wh Stock",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return const StockListItem();
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomButton(onTap: () {
              Navigator.pop(context);
            }, text: "Close"),
          )
        ],
      ),
    );
  }
}
