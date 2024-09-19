import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';

import '../../../../db/entities/outlet/outlet.dart';
import '../../../../utils/Colors.dart';

class OutletListItem extends StatelessWidget {
  final Function(Outlet) onTap;
  final Outlet outlet;
  final OrderStatus? orderStatus;

  const OutletListItem(
      {super.key,
      required this.onTap,
      required this.outlet,
      required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(outlet),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                  Text(
                    "${outlet.outletName} - ${outlet.location}",
                    style: GoogleFonts.roboto(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Outlet Code: ${outlet.outletCode ?? "OutletCOde"}",
                    style: GoogleFonts.roboto(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Sales in CS: ${outlet.mtdSale ?? "0"}",
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
            SizedBox(
                height: 28,
                width: 28,
                child: getImageWidget() ?? const SizedBox()),
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

  Widget? getImageWidget() {
    int visitStatus = outlet.visitStatus ?? 0;

    if (visitStatus == 0) {
      visitStatus = outlet.statusId ?? 0;
      outlet.synced = true;
    }

    Widget? imageWidget;

    if (orderStatus != null) {
      if (visitStatus < 1) {
        imageWidget = null;
      } else if (((visitStatus > 1 && visitStatus <= 6) || visitStatus >= 7) &&
          (outlet.synced ?? false)) {
        imageWidget = Image.asset(
          "assets/images/ic_done.png",
          color: Colors.green,
          colorBlendMode: BlendMode.color,
        );
      } else if (orderStatus?.data == null) {
        imageWidget = Image.asset("assets/images/ic_empty_order.png");
      } else {
        imageWidget = Image.asset(
          "assets/images/ic_done.png",
          color: Colors.red,
          colorBlendMode: BlendMode.color,
        );
      }
    } else {
      if (visitStatus < 1) {
        imageWidget = null;
      } else if (((visitStatus > 1 && visitStatus <= 6) || visitStatus >= 7) &&
          (outlet.synced ?? false)) {
        imageWidget = Image.asset(
          "assets/images/ic_done.png",
          color: Colors.green,
          colorBlendMode: BlendMode.color,
        );
      } else {
        imageWidget = Image.asset(
          "assets/images/ic_done.png",
          color: Colors.red,
          colorBlendMode: BlendMode.color,
        );
      }
    }

    // show outlet pending or uploaded status icon color
    if (orderStatus != null) {
      if (orderStatus?.requestStatus == null ||
          orderStatus!.requestStatus == 0) {
        imageWidget = Image.asset(
          "assets/images/ic_done.png",
          color: Colors.red,
          colorBlendMode: BlendMode.color,
        );
        if (orderStatus!.data == null) {
          imageWidget = Image.asset("assets/images/ic_empty_order.png");
        }
      } else if (orderStatus!.requestStatus == 3) {
        imageWidget = Image.asset(
          "assets/images/ic_done.png",
          color: Colors.green,
          colorBlendMode: BlendMode.color,
        );
      } else {
        imageWidget = Image.asset(
          "assets/images/ic_done.png",
          color: Colors.amber,
          colorBlendMode: BlendMode.screen,
        );
      }
    }

    return imageWidget;
  }
}
