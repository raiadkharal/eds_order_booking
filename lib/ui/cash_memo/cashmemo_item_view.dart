import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/ui/cash_memo/cash_memo_rate_view.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:order_booking/utils/PreferenceUtil.dart';
import 'package:order_booking/utils/util.dart';

import '../../db/entities/carton_price_breakdown/carton_price_breakdown.dart';
import '../../db/entities/unit_price_breakdown/unit_price_breakdown.dart';
import '../../db/models/price_breakdown/price_breakdown.dart';
import '../../model/order_detail_and_price_breakdown/order_detail_and_price_breakdown.dart';

class CashMemoItemView extends StatefulWidget {
  final OrderDetailAndPriceBreakdown item;
  final Function(bool)? priceListener;

  const CashMemoItemView(
      {super.key, required this.item, required this.priceListener});

  @override
  State<CashMemoItemView> createState() => _CashMemoItemViewState();
}

class _CashMemoItemViewState extends State<CashMemoItemView> {
  List<MapEntry<PriceBreakDown, List<PriceBreakDown>>> listOfEntries = [];
  late final OrderDetail _item;

  final RxBool _isExpanded = false.obs;

  @override
  void initState() {
    _item = widget.item.orderDetail;
    createPriceBreakDown(_item);
    initializeCartItem();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _isExpanded(!_isExpanded.value);
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 5,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SizedBox(
                          width: 8,
                          height: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: secondaryColor),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: secondaryColor,
                          width: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: SizedBox(
                          width: 8,
                          height: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: secondaryColor),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          widget.item.orderDetail.mProductName.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 5, bottom: 5, top: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity: ",
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Text(
                              _getProductQuantity(),
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Obx(
                          () => _isExpanded.value
                              ? Container(
                                  height: 85,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 5),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return CashMemoRateView(
                                          item: listOfEntries[index]);
                                    },
                                    itemCount: listOfEntries.length,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                      Obx(() => _isExpanded.value
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total: ",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    " Rs ${(widget.item.orderDetail.cartonTotalPrice ?? 0.0).toString()}",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox()),
                      Obx(
                        () => !_isExpanded.value
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Total: ",
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _getTotalPrice(),
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createPriceBreakDown(OrderDetail orderDetail) {
    if (Util.isListEmpty(orderDetail.unitPriceBreakDown) &&
        Util.isListEmpty(orderDetail.cartonPriceBreakDown)) return;

    List<CartonPriceBreakDown> cartonPriceBreakDowns =
        orderDetail.cartonPriceBreakDown ?? [];
    List<UnitPriceBreakDown> unitPriceBreakDowns =
        orderDetail.unitPriceBreakDown ?? [];

    List<PriceBreakDown> breakDowns = cartonPriceBreakDowns
        .map(
          (e) => PriceBreakDown.fromJson(e.toJson()),
        )
        .toList();
    breakDowns.addAll(unitPriceBreakDowns
        .map((e) => PriceBreakDown.fromJson(e.toJson()))
        .toList());

    Map<PriceBreakDown, List<PriceBreakDown>> listHashMap =
        calculate(breakDowns);

    // Sort method needs a List, so let's first convert HashList to List in Java
    listOfEntries = listHashMap.entries.toList();

    // Sort the list of entries based on priceConditionClassOrder
    listOfEntries.sort((a, b) {
      int orderA = a.key.priceConditionClassOrder ?? 0;
      int orderB = b.key.priceConditionClassOrder ?? 0;
      return orderA.compareTo(orderB);
    });

    for (MapEntry<PriceBreakDown, List<PriceBreakDown>> entry
        in listOfEntries) {
      double unitPrice = 0.0, cartonPrice = 0.0;
      String type = "";

      for (PriceBreakDown breakDown in entry.value) {
        cartonPrice = breakDown.blockPrice ?? 0;
        unitPrice = breakDown.blockPrice ?? 0;
        type = breakDown.priceConditionType ?? "";
      }
    }
  }

  Map<PriceBreakDown, List<PriceBreakDown>> calculate(
      List<PriceBreakDown> priceBreakDownList) {
    PriceBreakDown? promos, discount, tax, tradePrice;
    Map<PriceBreakDown, List<PriceBreakDown>> hashMap = {};

    for (PriceBreakDown breakDown in priceBreakDownList) {
      if (!(breakDown.priceConditionClass?.toLowerCase() == "retailer margin" ||
          breakDown.priceConditionClass?.toLowerCase() ==
              "market discount hth" ||
          breakDown.priceConditionClass?.toLowerCase() == "rental discount" ||
          breakDown.priceConditionClass?.toLowerCase() == "promotions" ||
          breakDown.priceConditionClass?.toLowerCase() == "consumer rate off" ||
          breakDown.priceConditionClass?.toLowerCase() == "tax")) {
        continue;
      }

      // add updated list items here...... /1
      if (breakDown.priceConditionClass?.toLowerCase() == "retailer margin") {
        breakDown.blockPrice = double.parse(breakDown.totalPrice.toString());
        breakDown.priceConditionType = "Trade Price";
        tradePrice = breakDown;
        tradePrice.priceConditionClassOrder = 1;
      }

      //2
      if (breakDown.priceConditionClass?.toLowerCase() ==
              "market discount hth" ||
          breakDown.priceConditionClass?.toLowerCase() == "rental discount") {
        breakDown.priceConditionType = "Discounts";
        if (discount != null) {
          discount.blockPrice = breakDown.blockPrice;
        } else {
          discount = breakDown;
        }
        discount.priceConditionClassOrder = 2;
      }

      //3
      if (breakDown.priceConditionClass?.toLowerCase() == "consumer rate off" ||
          breakDown.priceConditionClass?.toLowerCase() == "promotions") {
        breakDown.priceConditionType = "Promos";
        if (promos != null) {
          promos.blockPrice = breakDown.blockPrice;
        } else {
          promos = breakDown;
        }

        promos.priceConditionClassOrder = 3;
      }

      //4
      if (breakDown.priceConditionClass?.toLowerCase() == "tax") {
        breakDown.priceConditionType = "Tax";
        if (tax != null) {
          tax.blockPrice = breakDown.blockPrice;
        } else {
          tax = breakDown;
        }
        tax.priceConditionClassOrder = 4;
      }

      //...........................................................................................................................................
    }
    tradePrice = tradePrice ?? PriceBreakDown(1, "Trade Price");
    discount = discount ?? PriceBreakDown(2, "Discounts");
    promos = promos ?? PriceBreakDown(3, "Promos");
    tax = tax ?? PriceBreakDown(4, "Tax");

    hashMap[tradePrice] = [tradePrice];
    hashMap[discount] = [discount];
    hashMap[promos] = [promos];
    hashMap[tax] = [tax];

    return hashMap;
  }

  String _getTotalPrice() {
    double cartonTotalPrice = _item.cartonTotalPrice ?? 0.0;
    double unitTotalPrice = _item.unitTotalPrice ?? 0.0;

    double totalPrice = cartonTotalPrice + unitTotalPrice;

    return Util.formatCurrency(totalPrice, 2);
  }

  void initializeCartItem() {
    int cartonQty = _item.mCartonQuantity ?? 0;
    int unitQty = _item.mUnitQuantity ?? 0;

    double cartonTotalPrice = _item.cartonTotalPrice ?? 0.0;
    double unitTotalPrice = _item.unitTotalPrice ?? 0.0;

    if (widget.priceListener != null) {
      bool priceFound = true;
      if ((cartonQty > 0 && cartonTotalPrice <= 0) ||
          (unitQty > 0 && unitTotalPrice <= 0)) {
        priceFound = false;
      }

      widget.priceListener!(priceFound);
    }

    String free = "";
    int freeCarton = _item.cartonFreeGoodQuantity ?? 0;
    int freeUnits = _item.unitFreeGoodQuantity ?? 0;

    if (_item.cartonFreeQuantityTypeId == Constants.PRIMARY ||
        _item.unitFreeQuantityTypeId == Constants.PRIMARY) {
      free = "All";
    } else if (freeCarton > 0 || freeUnits > 0) {
      free = "$freeCarton / $freeUnits";
    } else {
      free = "None";
    }


  }

  String _getProductQuantity() {

    final PreferenceUtil preferenceUtil = Get.find<PreferenceUtil>();

    if(!preferenceUtil.getPunchOrderInUnits()){
      return _item.getQuantity();
    }else{
      return _item.getWithoutUnitQuantity();
    }

  }
}
