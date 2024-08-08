import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/models/last_order/last_order.dart';
import 'package:order_booking/db/models/last_order/order_detail.dart';
import 'package:order_booking/utils/Colors.dart';


class LastOrderDialog extends StatelessWidget {
  final LastOrder? order;

  const LastOrderDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      insetPadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text("Last Order",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)),
            Flexible(
              fit: FlexFit.loose,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    OrderDetail? orderDetail = order?.orderDetails?[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  orderDetail?.productName ?? "Product Name",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Qty: ",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    orderDetail?.quantity.toString()??"0.0",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Total: ",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                "Rs. ${orderDetail?.productTotal.toString()??"0.0"}",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      color: Colors.grey,
                      height: 0.5,
                    );
                  },
                  itemCount: order?.orderDetails?.length??0),
            ),
            // Container(
            //   color: Colors.grey,
            //   width: MediaQuery.of(context).size.width,
            //   height: 1,
            // ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.roboto(color: secondaryColor),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
