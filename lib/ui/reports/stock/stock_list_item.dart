import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/product/product.dart';

import '../../../utils/util.dart';

class StockListItem extends StatelessWidget {
  final Product product;
  const StockListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.productName.toString(),
                  style: GoogleFonts.roboto(
                      fontSize: 11,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Container(
                  color: Colors.grey,
                  width: 120,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                          product.cartonStockInHand.toString(),
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     const Expanded(flex: 14, child: SizedBox()),
          //     Expanded(
          //       flex: 10,
          //       child: Container(
          //         color: Colors.grey,
          //         child: Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: Text(
          //             "20.30",
          //             style: GoogleFonts.roboto(
          //                 fontSize: 12,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.normal),
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 2,
          //     ),
          //     Expanded(
          //       flex: 8,
          //       child: TextField(
          //         decoration: InputDecoration(
          //           isDense: true,
          //           contentPadding: const EdgeInsets.symmetric(
          //               horizontal: 10, vertical: 10),
          //           border: const OutlineInputBorder(
          //               borderSide: BorderSide(color: Colors.grey)),
          //           focusedBorder: const OutlineInputBorder(
          //               borderSide: BorderSide(color: Colors.grey)),
          //           hintText: "Avl Stock",
          //           fillColor: Colors.white,
          //           hintStyle: GoogleFonts.roboto(
          //               fontSize: 12,
          //               color: Colors.grey,
          //               fontWeight: FontWeight.normal),
          //         ),
          //         style: GoogleFonts.roboto(
          //             fontSize: 12,
          //             color: Colors.grey,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 2,
          //     ),
          //     Expanded(
          //       flex: 8,
          //       child: TextField(
          //         decoration: InputDecoration(
          //           isDense: true,
          //           contentPadding: const EdgeInsets.symmetric(
          //               horizontal: 10, vertical: 10),
          //           border: const OutlineInputBorder(
          //               borderSide: BorderSide(color: Colors.black)),
          //           focusedBorder: const OutlineInputBorder(
          //               borderSide: BorderSide(color: Colors.black)),
          //           hintText: "Order",
          //           fillColor: Colors.white,
          //           hintStyle: GoogleFonts.roboto(
          //               fontSize: 12,
          //               color: Colors.grey,
          //               fontWeight: FontWeight.normal),
          //         ),
          //         style: GoogleFonts.roboto(
          //             fontSize: 12,
          //             color: Colors.grey,
          //             fontWeight: FontWeight.normal),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 2,
          //     ),
          //     if(false)
          //       const Image(image: AssetImage("assets/images/return_icon.png"))
          //   ],
          // )
        ],
      ),
    );
  }
}
