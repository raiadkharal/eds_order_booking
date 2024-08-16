import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/reports/report_model.dart';
import 'package:order_booking/ui/reports/reports_view_model.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:order_booking/utils/util.dart';

import '../../db/entities/route/route.dart';
import '../../utils/Colors.dart';
import '../route/outlet/outlet_detail/outlet_detail_repository.dart';
import '../route/outlet/outlet_list/outlet_list_repository.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportsViewModel _controller = Get.put<ReportsViewModel>(
      ReportsViewModel(
          OutletDetailRepository(
              Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
          Get.find(),
          OutletListRepository(Get.find(), Get.find())));

  RxString tvRoutes = "".obs;
  RxString tvGrandTotal = "".obs;
  RxString tvOrderQty = "".obs;
  RxString tvCompRate = "".obs;
  RxString tvStrikeRate = "".obs;
  RxString tvAvgSku = "".obs;
  RxString tvDropSize = "".obs;
  RxString tvPlannedCount = "".obs;
  RxString tvCompletedCount = "".obs;
  RxString tvProductiveCount = "".obs;
  RxString tvConfirmedTotal = "".obs;
  RxString tvPendingTotal = "".obs;
  RxString tvConfirmedQty = "".obs;
  RxString tvConfirmedOrders = "".obs;
  RxString routesTv = "".obs;
  RxString tvSyncCount = "".obs;

  @override
  void initState() {
    super.initState();

    _setObservers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Expanded(
              child: Text(
            "KPI Report",
            style: GoogleFonts.roboto(color: Colors.white),
          ))),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Obx(() =>  Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tvRoutes.value,
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),

            // outlets counts by their statuses

            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 31,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          Constants.reportTopSummaryTitles[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Obx(() => Text(
                          _getValueByIndex(_controller.summaryLiveData,index),
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),),
                      ),
                    ],
                  );
                },
                itemCount: 5,
              ),
            ),

            //completion rate section

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 31,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          Constants.reportTopSummaryTitles2[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Obx(() => Text(
                          index == 0 ? tvCompRate.value : tvStrikeRate.value,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),

            //performance section

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 31,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          Constants.reportTopSummaryTitles3[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles3.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Obx(() => Text(
                          index == 0 ? tvAvgSku.value : tvDropSize.value,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),

            // carton and total amount section

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    "Carton(s)",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Total Amount",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5)),
                      child:Obx(() =>  Text(
                        tvOrderQty.value,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5)),
                      child: Obx(() => Text(
                        tvGrandTotal.value,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),),
                    ),
                  ),
                ],
              ),
            ),

            //Confirmed Orders section

            const SizedBox(
              height: 20,
            ),
            Text(
              "Confirmed Orders:",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 34,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          Constants.reportQuantityTitles[index],
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportQuantityTitles.length,
              ),
            ),
            SizedBox(
              height: 30,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: grayColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Obx(() => Text(
                          index == 0 ? tvConfirmedQty.value : tvConfirmedTotal.value,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),),
                      ),
                    ],
                  );
                },
                itemCount: Constants.reportTopSummaryTitles2.length,
              ),
            ),
          ],
        ),),
      ),
    );
  }

  void _setObservers() {
    debounce(_controller.getRoutes(), (routeList) {
      _onRoutesLoaded(routeList);
    }, time: const Duration(milliseconds: 200));

    debounce(_controller.summaryLiveData, (reportModel) {
      tvGrandTotal(Util.formatCurrency(reportModel.getTotalAmount(),2));
      tvPlannedCount(reportModel.getPjpCount().toString());
      tvCompletedCount(reportModel.getCompletedOutletsCount().toString());
      tvProductiveCount(reportModel.getProductiveOutletCount().toString());
      tvConfirmedOrders("Confirmed Orders: ${reportModel.getTotalConfirmOrders()}");
      tvConfirmedTotal(Util.formatCurrency(reportModel.getTotalAmountConfirm(),2));
      tvPendingTotal(reportModel.getPendingCount().toString());
      tvSyncCount(reportModel.getSyncCount().toString());

      double qty = double.parse(reportModel.getCarton().toStringAsFixed(2));
      double confirmQty = double.parse(reportModel.getCartonConfirm().toStringAsFixed(2));
      tvOrderQty(qty.toString());
      tvConfirmedQty(confirmQty.toString());
      setRatio(reportModel , qty);
    },time: const Duration(milliseconds: 200));
  }

  void _onRoutesLoaded(List<MRoute> routeList) {
    String routeDesc = "";
    for (MRoute route in routeList) {
      routeDesc += ("${route.routeName} ${routeList.length > 1 ? "\n" : ""}");
    }
    tvRoutes(routeDesc);
    _controller.getReport();
  }

  void setRatio(ReportModel summary, double totalCasesOrder) {
    int completed = summary.completedOutletsCount;
    double planned = summary.pjpCount == 0 ? 1 : summary.pjpCount.toDouble();
    int productive = summary.productiveOutletCount;

    double avgSku = summary.totalSku / summary.totalOrders;
    double dropSize = totalCasesOrder / productive;

    double compRate = (completed / planned) * 100;
    double strikeRate = (productive / planned) * 100;
    double completionRate = ((planned - (planned - (productive + completed))) * 100) / planned;

    tvCompRate("${completionRate.toStringAsFixed(1)} %");
    tvStrikeRate("${strikeRate.toStringAsFixed(1)} %");
    tvAvgSku("${avgSku.isNaN ? 0 : avgSku.toStringAsFixed(1)}");
    tvDropSize("${dropSize.isNaN ? 0 : dropSize.toStringAsFixed(1)}");
  }

  String _getValueByIndex(Rx<ReportModel> summaryLiveData,int index) {
    switch(index){
      case 0:
        return tvPlannedCount.value;
      case 1:
        return tvCompletedCount.value;
      case 2:
        return tvProductiveCount.value;
      case 3:
        return tvPendingTotal.value;
      case 4:
        return tvSyncCount.value;
    }
    
    return "0";
  }

}
