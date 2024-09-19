import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/components/button/cutom_button.dart';
import 'package:order_booking/components/dialog/no_order_reasons_dialog.dart';
import 'package:order_booking/components/progress_dialog/PregressDialog.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/order/order_booking_list_item.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';
import 'package:order_booking/ui/order/order_booking_view_model.dart';
import 'package:order_booking/utils/util.dart';
import 'package:order_booking/utils/utils.dart';

import '../../db/entities/packages/package.dart';
import '../../model/custom_object/custom_object.dart';
import '../../utils/Colors.dart';
import '../../utils/Constants.dart';

class OrderBookingScreen extends StatefulWidget {
  const OrderBookingScreen({super.key});

  @override
  State<OrderBookingScreen> createState() => _OrderBookingScreenState();
}

class _OrderBookingScreenState extends State<OrderBookingScreen> {
  final OrderBookingViewModel controller = Get.find<OrderBookingViewModel>();

  List<CustomObject> noOrderReasonList = [];

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      controller.loadOutlet(args[0]);
    }

    controller.init();
    _createNoOrderReasonList();
    _setObservers();
  }

  @override
  Widget build(BuildContext context) {
    controller.filterProductsByPackage(controller.package?.packageId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "Order Booking",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 2, right: 2),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
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
                                    if (controller.package != null) {
                                      _onAdd(
                                          controller.package!.packageId, false);
                                    }
                                    controller.package = value as Package;
                                    controller.filterProductsByPackage(
                                        controller.package?.packageId);
                                  },
                                  value: controller.getAllPackages().isNotEmpty
                                      ? controller.getAllPackages()[0]
                                      : "No Packages",
                                  isDense: true,
                                  isExpanded: true,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  items: controller.getAllPackages().isNotEmpty
                                      ? controller
                                          .getAllPackages()
                                          .map(
                                            (package) => DropdownMenuItem(
                                                value: package,
                                                child: Text(
                                                  package.packageName ?? "",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black54),
                                                )),
                                          )
                                          .toList()
                                      : [],
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
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
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
                        if (controller.isShowMarketReturnButton())
                          Text(
                            "Return",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      Product item = controller.filteredProducts[index];
                      return OrderBookingListItem(
                        product: item,
                        autoFocus: false,
                        avlStockController: _getAvailableStockController(item),
                        orderQtyController: _getOrderControllerController(item),
                        showMarketReturnButton:
                            controller.isShowMarketReturnButton(),
                        onReturnClick: (product) {

                          //preserve order and available stock quantity on navigation
                          controller.saveOrderAndAvailableStockData();

                          Get.toNamed(EdsRoutes.marketReturn, arguments: [
                            product.id,
                            controller.outlet?.outletId,
                            _convertStockInUnit(
                                controller
                                    .orderQtyControllers[product.id]?.text,
                                product.cartonQuantity)
                          ])?.then(
                            (value) {
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                    itemCount: controller.filteredProducts.length,
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CustomButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      _onNextClick();
                    },
                    text: "Next"),
              )
            ],
          ),
          Obx(
            () => controller.getIsSaving().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void _onAdd(int? packageId, bool sendToServer) async {
    final List<Product> orderItems = await controller.filterOrderProducts();
    controller.updateAvlStockItems(packageId);
    controller.addOrder(orderItems, packageId, sendToServer);
  }

  void _onNextClick() {
    if (controller.package != null) {
      _onAdd(controller.package!.packageId, true);
    }

    controller.saveOrderAndAvailableStockData();
  }

  void _setObservers() {
    debounce(controller.getProductList(), (products) {
      controller.updateFilteredProducts(products);
    }, time: const Duration(milliseconds: 100));

    debounce(
      controller.noOrderTaken(),
      (aBoolean) {
        if (aBoolean) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                insetPadding: const EdgeInsets.all(20),
                title: const Text("Checkout Without Order!"),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "Are you sure you want to checkout without any Order?"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _pickReasonForNoOrder();
                              },
                              child: const Text("Yes"))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );

    debounce(
      controller.orderSaved(),
      (aBoolean) {
        if (aBoolean) {
          Get.toNamed(EdsRoutes.cashMemo,
              arguments: [controller.outlet?.outletId, false, 0])?.then(
            (result) {
              if(result!=null&&result[Constants.STATUS_OK]) {
                Get.back(result: result);
              }
            },
          );
        }
      },
    );

    /*   debounce(
      controller.getIsSaving(),
      (aBoolean) {
        if (aBoolean) {
          //TODO- show progress dialog
        } else {
          //TODO- hide progress dialog
        }
      },
    );*/

    debounce(
      controller.getMessage(),
      (message) {
        showToastMessage(message);
      },
    );
  }

  void _createNoOrderReasonList() {
    noOrderReasonList.add(CustomObject(1, "Buying from WS"));
    noOrderReasonList.add(CustomObject(2, "Converted to coke"));
    noOrderReasonList.add(CustomObject(3, "No Funds"));
    noOrderReasonList.add(CustomObject(4, "No Owner"));
    noOrderReasonList.add(CustomObject(5, "Over Stock"));
    noOrderReasonList.add(CustomObject(6, "Price Disparity"));
//        noOrderReasonList.add(new CustomObject(1L, "Sufficient Stock"));
//        noOrderReasonList.add(new CustomObject(2L, "Price Variation"));
//        noOrderReasonList.add(new CustomObject(3L, "Buying from WS"));
//        noOrderReasonList.add(new CustomObject(4L, "Out of Cash"));
//        noOrderReasonList.add(new CustomObject(5L, "Dispute"));
  }

  int _convertStockInUnit(String? orderQty, int? cartonQty) {
    if (orderQty == null || orderQty.isEmpty) {
      return 0;
    }
    final cu = Util.convertToLongQuantity(orderQty);
    return Util.convertToUnits(cu?[0], cartonQty, cu?[1]);
  }

  void _pickReasonForNoOrder() {
    showDialog(
      context: context,
      builder: (context) => NoOrderReasonsDialog(
          title: Constants.no_order_reason,
          listener: (object) {
            onNoOrderReasonSelected(object);
          },
          viewModel: controller,
          outlet: controller.outlet,
          options: noOrderReasonList),
    );
  }

  void onNoOrderReasonSelected(CustomObject object) {
    Map<String, dynamic> extraParams = {
      Constants.STATUS_OK:true,
      Constants.EXTRA_PARAM_OUTLET_REASON_N_ORDER: object.id,
      Constants.EXTRA_PARAM_NO_ORDER_FROM_BOOKING: true,
      Constants.EXTRA_PARAM_OUTLET_ID: controller.outlet?.outletId,
    };
    Get.back(result: extraParams);
  }

  TextEditingController? _getAvailableStockController(Product product) {
    TextEditingController? stockController =
        controller.avlStockControllers[product.id];

  /*  final avlStock = Util.convertStockToNullableDecimalQuantity(
        product.avlStockCarton, product.avlStockUnit);
    if (avlStock != null) {
      stockController?.text = avlStock;
    } else {
      stockController?.clear();
    }*/

    return stockController;
  }

  TextEditingController? _getOrderControllerController(Product product) {
    TextEditingController? orderController =
        controller.orderQtyControllers[product.id];
/*
    final orderQty = Util.convertStockToNullableDecimalQuantity(
        product.qtyCarton, product.qtyUnit);
    if (orderQty != null) {
      orderController?.text = orderQty;
    } else {
      orderController?.clear();
    }*/

    return orderController;
  }
}
