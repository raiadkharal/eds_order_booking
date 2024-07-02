
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../db/entities/outlet/outlet.dart';
import '../../../../utils/Colors.dart';


class OutletListItem extends StatelessWidget {
  final Function(int) onTap;
  final Outlet outlet;
  const OutletListItem(
      {super.key,
        required this.onTap,
        required this.outlet});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(outlet.outletId??0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(outlet.outletName?.toUpperCase() ?? "Outlet Name",
                    style: GoogleFonts.roboto(
                        color: primaryColor,

                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Outlet Code: ${ outlet.outletCode ?? "OutletCOde"}",
                    style: GoogleFonts.roboto(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Sales in CS: ${ outlet.mtdSale ?? "0"}",
                    style: GoogleFonts.roboto(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  if (outlet.isZeroSaleOutlet ?? false)
                    Text(
                      "NO SALE",
                      style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                ],
              ),
            ),
            if (outlet.synced ?? false)
              SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset("assets/images/ic_done.png")),
            const SizedBox(
              width: 8,
            ),
            if (outlet.isZeroSaleOutlet ?? false)
              Container(
                color: Colors.red.shade800,
                height: 80,
                width: 10,
              )
          ],
        ),
      ),
    );
  }
}
