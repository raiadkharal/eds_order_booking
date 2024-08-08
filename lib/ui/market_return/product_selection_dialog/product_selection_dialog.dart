import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/utils/Constants.dart';

import '../../../utils/Colors.dart';
import '../../../utils/utils.dart';
import '../../order/order_booking_repository.dart';
import '../../order/order_booking_view_model.dart';

class ProductSelectionDialog extends StatefulWidget {
  final Function(Product?) onSaveClick;
  const ProductSelectionDialog({super.key, required this.onSaveClick});

  @override
  State<ProductSelectionDialog> createState() => _ProductSelectionDialogState();
}

class _ProductSelectionDialogState extends State<ProductSelectionDialog> {

  final controller = Get.put(OrderBookingViewModel(
      OrderBookingRepository(Get.find(), Get.find(), Get.find(), Get.find()),
      Get.find(),
      Get.find()));

  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text("SELECT PRODUCT"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PACKAGE: ",style: GoogleFonts.roboto(color: Colors.black87),),
                Container(color: Colors.black87,height: 1,width: double.infinity,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() => DropdownButtonFormField(
                        onChanged: (value) {},
                        isDense: true,
                        isExpanded: false,
                        value: controller.getAllPackages().isNotEmpty
                            ? controller.getAllPackages()[0]
                            : "No Packages",
                        alignment: Alignment.centerRight,
                        decoration: const InputDecoration(
                          focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        items: controller.getAllPackages()
                            .map(
                              (package) => DropdownMenuItem(
                              value: package,
                              child: Text(
                                package.packageName??"",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54),
                              )),
                        )
                            .toList(),
                      ),),
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PRODUCT: ",style: GoogleFonts.roboto(color: Colors.black87),),
                Container(color: Colors.black87,height: 1,width: double.infinity,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          _selectedProduct=value as Product;
                        },
                        isDense: true,
                        isExpanded: false,
                        value: controller.filteredProducts.isNotEmpty
                            ? controller.filteredProducts[0]
                            : "No Products",
                        alignment: Alignment.centerRight,
                        decoration: const InputDecoration(
                          focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        items: controller.filteredProducts
                            .map(
                              (product) => DropdownMenuItem(
                              value: product,
                              child: Text(
                                product.productName  ?? "",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54),
                              )),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.roboto(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onSaveClick(_selectedProduct);
                        },
                      child: Text(
                        "Save",
                        style: GoogleFonts.roboto(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
