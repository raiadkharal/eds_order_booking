import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/PreferenceUtil.dart';
import 'package:order_booking/utils/util.dart';

import '../../db/models/price_breakdown/price_breakdown.dart';

class CashMemoRateView extends StatefulWidget {
  final MapEntry<PriceBreakDown, List<PriceBreakDown>> item;
  const CashMemoRateView({super.key, required this.item});

  @override
  State<CashMemoRateView> createState() => _CashMemoRateViewState();
}

class _CashMemoRateViewState extends State<CashMemoRateView> {

  Rx<String> title = "".obs;
  Rx<String> rate = "".obs;

  @override
  void initState() {

    initRateValues();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Obx(() => Text(title.value,style: GoogleFonts.roboto(color: Colors.black54,fontSize: 14),),),
        Obx(() => Text(rate.value,style: GoogleFonts.roboto(color: Colors.black54,fontSize: 14)),)
      ],
    );
  }

  void initRateValues() {
      double unitPrice = 0.0, cartonPrice = 0.0;
      String type = "";

      for (PriceBreakDown breakDown in widget.item.value) {
        cartonPrice = breakDown.blockPrice ?? 0.0;
        unitPrice = breakDown.blockPrice ?? 0.0;
        type = breakDown.priceConditionType ?? "";
      }

      PreferenceUtil preferenceUtil =Get.find<PreferenceUtil>();

      if (!preferenceUtil.getPunchOrderInUnits()) {
        rate("${Util.formatCurrency(cartonPrice.toDouble(),0)} / ${Util.formatCurrency(unitPrice.toDouble(),0)}");
      } else {
        rate(Util.formatCurrency(cartonPrice.toDouble(),0));
      }
      title(type);

  }
}
