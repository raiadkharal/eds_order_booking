import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/order_quantity/order_quantity.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/cash_memo/cash_memo_free_item_view.dart';
import 'package:order_booking/ui/cash_memo/cash_memo_repository.dart';
import 'package:order_booking/ui/cash_memo/cash_memo_view_model.dart';
import 'package:order_booking/ui/cash_memo/cashmemo_item_view.dart';

import '../../components/button/cutom_button.dart';
import '../../db/entities/order_status/order_status.dart';
import '../../db/entities/unit_price_breakdown/unit_price_breakdown.dart';
import '../../model/order_detail_and_price_breakdown/order_detail_and_price_breakdown.dart';
import '../../route.dart';
import '../../utils/Colors.dart';
import '../../utils/Constants.dart';
import '../../utils/util.dart';
import '../route/outlet/outlet_detail/outlet_detail_repository.dart';

class CashMemoScreen extends StatefulWidget {
  const CashMemoScreen({super.key});

  @override
  State<CashMemoScreen> createState() => _CashMemoScreenState();
}

class _CashMemoScreenState extends State<CashMemoScreen> {
  final CashMemoViewModel _controller = Get.put<CashMemoViewModel>(
      CashMemoViewModel(
          CashMemoRepository(Get.find(), Get.find()),
          OutletDetailRepository(
              Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
          Get.find()));

  OrderEntityModel? _orderModel;

  late final int? _outletId;
  late final int? _statusId;
  bool? _fromOutlet, cashMemoEditable = false;

  Widget? _bottomSheetDialog;

  final RxBool _btnNextEnabled = false.obs;
  final RxString _tvGrandTotal = "0.0".obs;
  final RxString _tvQty = "0.0".obs;
  final RxString _tvFreeQty = "0.0".obs;

  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      _outletId = args[0];
      _fromOutlet = args[1];
      _statusId = args[2];
    }

    _controller.loadOutlet(_outletId);

    if (_fromOutlet ?? false) {
      _controller.updateProduct(_outletId, false);
    }

    // initAdapter();
    _setObserver();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async => await _onBackPressed(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            title: Text(
              "Cash Memo",
              style: GoogleFonts.roboto(color: Colors.white),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Outlet Name: ",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Obx(
                      () => Text(
                        _controller.outletName.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    )),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (_bottomSheetDialog != null) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _bottomSheetDialog!,
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    color: secondaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 7,
                            child: Obx(
                              () => Text(
                                "Qty: ${_tvQty.value}",
                                style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                            )),
                        Expanded(
                            flex: 12,
                            child: Obx(
                              () => Text(
                                "Free Qty: ${_tvFreeQty.value}",
                                style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Expanded(
                            flex: 11,
                            child: Obx(
                              () => Text(
                                "Total: ${_tvGrandTotal.value}",
                                style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CashMemoItemView(
                        item: _controller.cartItemList[index],
                        priceListener: (isPriceAvailable) {
                          if (cashMemoEditable ?? false) {
                            _btnNextEnabled(isPriceAvailable);

                            if (!isPriceAvailable) {
                              _showVerificationAlertDialog(
                                "Oops!",
                                Constants.PRICING_CASHMEMO_ERROR,
                                (verified) {
                                  if (verified) {
                                    Navigator.of(context).pop();
                                  }
                                },
                              );
                            }
                          }
                        },
                      );
                    },
                    itemCount: _controller.cartItemList.length),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: MaterialButton(
                        onPressed: () {
                          _onEditOrderClick();
                        },
                        color: primaryColor,
                        child: Text(
                          "Edit Order",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )),
                    Expanded(
                        child: CustomButton(
                      onTap: () => _onNextClick(),
                      text: "Next",
                      minWidth: 100,
                      horizontalPadding: 3,
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setObserver() {
    debounce(_controller.getOrder(_outletId ?? 0), (orderModel) {
      _orderModel = orderModel;
      cashMemoEditable = orderModel.order?.orderStatus != 1;

      _controller.updateCartItems(orderModel.orderDetailAndCPriceBreakdowns);
      _updateOrderAndAvailableQuantity(orderModel.order?.outletId,
          orderModel.orderDetailAndCPriceBreakdowns);
      _updatePriceOnUi(orderModel);
    }, time: const Duration(milliseconds: 200));
  }

  void _updatePriceOnUi(OrderEntityModel order) {
    if (order.getOrder()?.priceBreakDown != null &&
        order.getOrder()!.priceBreakDown!.isNotEmpty) {
      _createBreakDownDialogSheet(order.order?.priceBreakDown,
          order.order?.subTotal, order.order?.payable);
    }

    if (order.order?.payable != null && order.order!.payable == 0.0) {
      _btnNextEnabled(false);
    } else if (order.order?.payable == null) {
      _btnNextEnabled(false);
    } else {
      _btnNextEnabled(true);
    }

    _tvGrandTotal(Util.formatCurrency(order.order?.payable, 0));
    int carton = 0, units = 0;
    if (order.orderDetailAndCPriceBreakdowns != null) {
      for (OrderDetailAndPriceBreakdown detailAndPriceBreakdown
          in order.orderDetailAndCPriceBreakdowns!) {
        int? cQty = detailAndPriceBreakdown.orderDetail.mCartonQuantity;
        int? uQty = detailAndPriceBreakdown.orderDetail.mUnitQuantity;
        carton += cQty ?? 0;
        units += uQty ?? 0;
      }
    }
    _tvQty("$carton.$units");
    if (order.freeAvailableQty != null) {
      _tvFreeQty(order.freeAvailableQty.toString());
    }
  }

  void _createBreakDownDialogSheet(List<UnitPriceBreakDown>? breakDowns,
      double? subTotal, double? grandTotal) {
    _bottomSheetDialog = Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add a Scrollable ListView to handle potentially large number of items
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: breakDowns?.length,
              itemBuilder: (BuildContext context, int index) {
                final priceBreakDown = breakDowns?[index];
                final unitPrice = priceBreakDown?.blockPrice;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(priceBreakDown?.priceConditionType ?? ""),
                      Text(Util.formatCurrency(unitPrice, 0)),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal:'),
                Text(Util.formatCurrency(subTotal, 0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:'),
                Text(Util.formatCurrency(grandTotal, 0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onEditOrderClick() async {
    if (_statusId != 7) {
      if (_orderModel != null) {
        if (_orderModel?.order?.serverOrderId != null) {
          OrderStatus? orderStatus =
              await _controller.findOrderStatus(_orderModel?.outlet?.outletId);
          orderStatus?.outletVisitStartTime =
              DateTime.now().millisecondsSinceEpoch;
          _controller.updateStatus(orderStatus);
        }
      }

      //Navigate to the order booking screen
      Get.offNamed(EdsRoutes.orderBooking, arguments: [_outletId]);
    }
  }

  Future<void> _onBackPressed() async {
    if (!(_fromOutlet  ?? false)) {
      if (_orderModel != null) {
        if (_orderModel?.order?.serverOrderId != null) {
          OrderStatus? orderStatus =
              await _controller.findOrderStatus(_orderModel?.outlet?.outletId);
          orderStatus?.outletVisitStartTime =
              DateTime.now().millisecondsSinceEpoch;
          _controller.updateStatus(orderStatus);
        }
      }
    }
  }

  void _showVerificationAlertDialog(
      String title, message, Function(bool) mListener) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Text(title, style: GoogleFonts.roboto()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: GoogleFonts.roboto()),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      mListener(false);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "No",
                      style: GoogleFonts.roboto(color: secondaryColor),
                    )),
                TextButton(
                    onPressed: () {
                      mListener(true);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Yes",
                      style: GoogleFonts.roboto(color: secondaryColor),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onNextClick() {
    Get.toNamed(EdsRoutes.customerInput, arguments: [_outletId])?.then(
      (result) {
        if (result != null && result[Constants.STATUS_OK]) {
          Get.back(result: result);
        }
      },
    );
  }

  Future<void> _updateOrderAndAvailableQuantity(int? outletId,
      List<OrderDetailAndPriceBreakdown>? orderDetailAndCPriceBreakdowns) async{

    List<OrderAndAvailableQuantity> orderAndAvailableQuantityList =[];

    for (OrderDetailAndPriceBreakdown orderDetailAndCPriceBreakdown
        in orderDetailAndCPriceBreakdowns ?? []) {

      OrderDetail orderDetail = orderDetailAndCPriceBreakdown.orderDetail;

      OrderAndAvailableQuantity orderAndAvailableQuantity =
          OrderAndAvailableQuantity(
              outletId: outletId,
              productId: orderDetail.mProductId,
              cartonQuantity: orderDetail.mCartonQuantity,
              unitQuantity: orderDetail.mUnitQuantity,
              avlCartonQuantity: orderDetail.avlCartonQuantity,
              avlUnitQuantity: orderDetail.avlUnitQuantity);

      orderAndAvailableQuantityList.add(orderAndAvailableQuantity);
    }

    //insert into database
    _controller.saveOrderAndAvailableStockData(orderAndAvailableQuantityList);
  }
}
