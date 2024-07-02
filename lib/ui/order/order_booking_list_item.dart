import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/util.dart';
import 'package:order_booking/utils/utils.dart';

import '../../db/entities/product/product.dart';

class OrderBookingListItem extends StatefulWidget {
  final Product product;

  const OrderBookingListItem({super.key, required this.product});

  @override
  State<OrderBookingListItem> createState() => _OrderBookingListItemState();
}

class _OrderBookingListItemState extends State<OrderBookingListItem> {
  final _avlStockQtyController = TextEditingController();
  final _orderQtyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product.avlStockCarton != null ||
        widget.product.avlStockUnit != null) {
      _avlStockQtyController.text = Util.convertStockToDecimalQuantity(
          widget.product.avlStockCarton, widget.product.avlStockUnit);
    }

    if (widget.product.qtyCarton != null || widget.product.qtyUnit != null) {
      _orderQtyController.text = Util.convertStockToDecimalQuantity(
          widget.product.qtyCarton, widget.product.qtyUnit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.productName.toString(),
              style: GoogleFonts.roboto(
                  fontSize: 11,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
        Row(
          children: [
            const Expanded(flex: 14, child: SizedBox()),
            Expanded(
              flex: 10,
              child: Container(
                color: Colors.grey.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    Util.convertStockToDecimalQuantity(
                        widget.product.cartonStockInHand,
                        widget.product.unitStockInHand),
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              flex: 8,
              child: TextField(
                controller: _avlStockQtyController,
                onChanged: (s) {
                  if (s.isEmpty || (s.length == 1 && s.toString() == ".")) {
                    widget.product.setAvlStock(null, null);
                    return;
                  }
                  double qty = double.parse(s.toString());
                  if (qty > 0) {
                    final cu = Util.convertToLongQuantity(s.toString());
                    widget.product.setAvlStock(cu[0], cu[1]);
//                    avlStock.add(position,new AvailableStock(product.id,cu[0]));
                  }
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: "Avl Stock",
                  fillColor: Colors.white,
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              flex: 8,
              child: TextField(
                controller: _orderQtyController,
                onChanged: (s) {
                  if (s.isEmpty ||
                      (s.length == 1 &&
                          (s.toString() == "." || s.toString() == "-"))) {
                    widget.product.setQty(null, null);
                    return;
                  }

                  double qty = 0;

                  try {
                    qty = double.parse(s.toString());
                  } catch (e) {
                    qty = 0;
                  }
                  int unitStock = widget.product.unitStockInHand ?? 0;
                  if (qty > 0) {
                    final cu = Util.convertToLongQuantity(s.toString());
                    int enteredQty = Util.convertToUnits(
                        cu[0], widget.product.cartonQuantity, cu[1]);
                    if (enteredQty > unitStock) {
                      // s = s.toString().substring(0,start);
                      // itemHolder.etOrderQty.setText(s.toString());
                      // itemHolder.etOrderQty.setSelection(start);
                      // mCallback.onInvalidQtyEntered();
                      showToastMessage("You cannot enter above maximum quantity");
                      _orderQtyController.text=s.substring(0,s.length-1);
                    } else {
                      widget.product.setQty(cu[0], cu[1]);
                    }
                  }
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Order",
                  fillColor: Colors.white,
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            if (false)
              const Image(image: AssetImage("assets/images/return_icon.png"))
          ],
        )
      ],
    );
  }
}
