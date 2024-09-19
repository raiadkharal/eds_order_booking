import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/components/progress_dialog/PregressDialog.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/route/route.dart';
import 'package:order_booking/db/models/outlet_order_status/outlet_order_status.dart';
import 'package:order_booking/db/models/work_status/work_status.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_item.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_view_model.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:order_booking/utils/utils.dart';

import '../../../../utils/device_info_util.dart';

class OutletListScreen extends StatefulWidget {
  const OutletListScreen({super.key});

  @override
  State<OutletListScreen> createState() => _OutletListScreenState();
}

class _OutletListScreenState extends State<OutletListScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(OutletListViewModel(
      OutletListRepository(Get.find(), Get.find(), Get.find()), Get.find()));
  late final MRoute route;

  final RxInt _selectedTab = 0.obs;

  late final TabController _tabController;
  late final TabController _pjpTabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _pjpTabController = TabController(length: 3, vsync: this);

    setObservers();

    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      route = args[0];
    } else {
      route = MRoute();
    }
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pjpTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            route.routeName ?? "Route Name",
            style: GoogleFonts.roboto(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(controller));
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: secondaryColor,
                  child: TabBar(
                    onTap: (index) {
                      //reset tab selection to pending PJP tab
                      // _pjpTabController.animateTo(0);
                      if (index == 1) {
                        controller
                            .loadUnPlannedOutlets(route.routeId ?? 102825);
                      }
                      setState(() {
                        _selectedTab(index);
                        controller.filterOutlets(_selectedTab.value, 0);
                      });
                    },
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.fill,
                    tabs: const [
                      Tab(
                        child: Text(
                          "PJP's",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Others",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => _selectedTab.value == 0
                      ? Container(
                          color: Colors.white,
                          child: TabBar(
                            controller: _pjpTabController,
                            indicatorColor: Colors.black,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabAlignment: TabAlignment.fill,
                            onTap: (index) => controller.filterOutlets(
                                _selectedTab.value, index),
                            tabs: [
                              Tab(
                                child: Obx(
                                  () => Text(
                                    "PENDING( ${controller.pendingOutlets.length} )",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 11),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Obx(
                                  () => Text(
                                    "NON PRODUCTIVE( ${controller.visitedOutlets.length} )",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 11),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Obx(
                                  () => Text(
                                    "PRODUCTIVE( ${controller.productiveOutlets.length} )",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 11),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Obx(
                      () => ListView.separated(
                        itemBuilder: (context, index) {
                          final outletOrderStatus =
                              controller.filteredOutlets[index];
                          return OutletListItem(
                            outlet: outletOrderStatus.outlet ?? Outlet(),
                            orderStatus: outletOrderStatus.orderStatus,
                            onTap: (outlet) async {

                              //check auto time and date enabled if not show message
                              bool isAutoTimeEnabled = await DeviceInfoUtil.isAutoTimeEnabled();

                              if (!isAutoTimeEnabled && !controller.isTestUser()) {
                                //ask user to enable auto date and time
                                _showAutoTimeWarningDialog();
                                return;
                              }

                              WorkStatus status = controller.getWorkSyncData();
                              if (status.dayStarted != 1) {
                                showToastMessage(status.dayStarted == 2
                                    ? "Your day has already ended"
                                    : "You have not even started your day");
                                return;
                              }

                              debounce(
                                  controller.orderTaken(outlet.outletId ?? 0),
                                  (aBoolean) {
                                if (aBoolean && outlet.statusId != 7) {
                                  Get.toNamed(EdsRoutes.cashMemo,
                                      arguments: [outlet.outletId, true, 0]);
                                } else {
                                  Get.toNamed(EdsRoutes.outletDetail,
                                      arguments: [outlet.outletId]);
                                }
                              }, time: const Duration(milliseconds: 200));
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Colors.grey,
                          );
                        },
                        itemCount: controller.filteredOutlets.length,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => controller.getLoading().value
                  ? const SimpleProgressDialog()
                  : const SizedBox(),
            )
          ],
        ));
  }

  void setObservers() {}

  void _showAutoTimeWarningDialog() {
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding: const EdgeInsets.all(20),
          title: const Text("Warning!"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please Enable auto Date and time",
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.roboto(
                              color: Colors.black54, fontSize: 16),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          DeviceInfoUtil.openDateTimeSettings();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Settings",
                          style: GoogleFonts.roboto(
                              color: Colors.black, fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}


class CustomSearchDelegate extends SearchDelegate {
  final OutletListViewModel controller;

  CustomSearchDelegate(this.controller);

  @override
  String? get searchFieldLabel => "Enter Outlet Name or Code";

  @override
  TextStyle? get searchFieldStyle => GoogleFonts.roboto(fontSize: 16);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<OutletOrderStatus> filteredItems = [];

    filteredItems = controller.filteredOutlets
        .where((outletOrderStatus) =>
            (outletOrderStatus.outlet?.outletName.toString() ?? "")
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            (outletOrderStatus.outlet?.outletCode.toString() ?? "")
                .contains(query))
        .toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final outletOrderStatus = filteredItems[index];
          return OutletListItem(
            outlet: outletOrderStatus.outlet ?? Outlet(),
            orderStatus: outletOrderStatus.orderStatus,
            onTap: (outlet) async {

              //check auto time and date enabled if not show message
              bool isAutoTimeEnabled = await DeviceInfoUtil.isAutoTimeEnabled();

              if (!isAutoTimeEnabled && !controller.isTestUser()) {
                //ask user to enable auto date and time
                _showAutoTimeWarningDialog(context);
                return;
              }

              WorkStatus status = controller.getWorkSyncData();
              if (status.dayStarted != 1) {
                showToastMessage(status.dayStarted == 2
                    ? "Your day has already ended"
                    : "You have not even started your day");
                return;
              }

              debounce(
                  controller.orderTaken(outlet.outletId ?? 0),
                      (aBoolean) {
                    if (aBoolean && outlet.statusId != 7) {
                      Get.toNamed(EdsRoutes.cashMemo,
                          arguments: [outlet.outletId, true, 0]);
                    } else {
                      Get.toNamed(EdsRoutes.outletDetail,
                          arguments: [outlet.outletId]);
                    }
                  }, time: const Duration(milliseconds: 200));
            },
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            color: Colors.grey,
          );
        },
        itemCount: filteredItems.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<OutletOrderStatus> filteredItems = [];

    filteredItems = controller.filteredOutlets
        .where((outletOrderStatus) =>
            (outletOrderStatus.outlet?.outletName.toString() ?? "")
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            (outletOrderStatus.outlet?.outletCode.toString() ?? "")
                .contains(query))
        .toList();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final outletOrderStatus = filteredItems[index];
          return OutletListItem(
            outlet: outletOrderStatus.outlet ?? Outlet(),
            orderStatus: outletOrderStatus.orderStatus,
            onTap: (outlet) async {

              //check auto time and date enabled if not show message
              bool isAutoTimeEnabled = await DeviceInfoUtil.isAutoTimeEnabled();

              if (!isAutoTimeEnabled && !controller.isTestUser()) {
                //ask user to enable auto date and time
                _showAutoTimeWarningDialog(context);
                return;
              }

              WorkStatus status = controller.getWorkSyncData();
              if (status.dayStarted != 1) {
                showToastMessage(status.dayStarted == 2
                    ? "Your day has already ended"
                    : "You have not even started your day");
                return;
              }

              debounce(
                  controller.orderTaken(outlet.outletId ?? 0),
                      (aBoolean) {
                    if (aBoolean && outlet.statusId != 7) {
                      Get.toNamed(EdsRoutes.cashMemo,
                          arguments: [outlet.outletId, true, 0]);
                    } else {
                      Get.toNamed(EdsRoutes.outletDetail,
                          arguments: [outlet.outletId]);
                    }
                  }, time: const Duration(milliseconds: 200));
            },
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            color: Colors.grey,
          );
        },
        itemCount: filteredItems.length,
      ),
    );
  }


  void _showAutoTimeWarningDialog(BuildContext context) {
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding: const EdgeInsets.all(20),
          title: const Text("Warning!"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please Enable auto Date and time",
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.roboto(
                              color: Colors.black54, fontSize: 16),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          DeviceInfoUtil.openDateTimeSettings();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Settings",
                          style: GoogleFonts.roboto(
                              color: Colors.black, fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
