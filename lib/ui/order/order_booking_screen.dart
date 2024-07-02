import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/components/button/cutom_button.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/ui/order/order_booking_list_item.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';
import 'package:order_booking/ui/order/order_booking_view_model.dart';

import '../../db/entities/packages/package.dart';
import '../../utils/Colors.dart';
import '../../utils/Constants.dart';

class OrderBookingScreen extends StatefulWidget {
  const OrderBookingScreen({super.key});

  @override
  State<OrderBookingScreen> createState() => _OrderBookingScreenState();
}

class _OrderBookingScreenState extends State<OrderBookingScreen> {
  final controller =
      Get.put(OrderBookingViewModel(OrderBookingRepository(Get.find(),Get.find())));

  Package? _package;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "Order Booking",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 2, right: 2),
            child: Card(
              elevation: 3,
              color: Colors.white,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          "Package Name: ",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 2,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(canvasColor: Colors.white),
                          child: Obx(
                            () => DropdownButtonFormField(
                              onChanged: (value) {
                                if(_package!=null){
                                  onAdd(_package!.packageId,false);
                                }
                                _package = value as Package;
                                controller.filterProductsByPackage(_package?.packageId);
                              },
                              value: controller.getAllPackages()[0],
                              isDense: true,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
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
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Card(
              elevation: 3,
              color: secondaryColor,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 14,
                        child: Text(
                          "Name",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start,
                        )),
                    Expanded(
                        flex: 12,
                        child: Text(
                          "Wh Stock",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                        flex: 8,
                        child: Text(
                          "Avl Stock",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                        flex: 8,
                        child: Text(
                          "Order",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
            child: Obx(() => ListView.builder(
              itemBuilder: (context, index) {
                return OrderBookingListItem(product: controller.filteredProducts[index],);
              },
              itemCount: controller.filteredProducts.length,
            ),),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomButton(onTap: () {
              onNextClick();
            }, text: "Next"),
          )
        ],
      ),
    );
  }

  void onAdd(int? packageId, bool sendToServer) {

    // final List<Product> orderItems = [];
    // controller.addOrder(orderItems,packageId,sendToServer);
  }

  void onNextClick() {
    if(_package!=null){
      onAdd(_package!.packageId, true);
    }
  }
}
