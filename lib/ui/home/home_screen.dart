import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/components/navigation_drawer/my_navigation_drawer.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/model/custom_object/custom_object.dart';
import 'package:order_booking/model/target_vs_achievement/target_vs_achievement.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/home/home_view_model.dart';
import 'package:order_booking/utils/Colors.dart';

import '../../components/button/home_button.dart';
import '../../components/progress_dialog/PregressDialog.dart';
import '../../db/models/work_status/work_status.dart';
import '../../utils/Constants.dart';
import '../../utils/util.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel controller = Get.find<HomeViewModel>();

  final Rx<TargetVsAchievement> _targetVsAchievement =
      TargetVsAchievement().obs;

  @override
  void initState() {
    init();

    setObservers();
    controller.checkDayEnd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(baseContext: context),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        title: Text(
          "EDS",
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Start Day
                              Expanded(
                                child: Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Obx(
                                      () => HomeButton(
                                        onTap: () {
                                          if (controller.startDay().value) {
                                            showToastMessage(
                                                "Already started your day");
                                          } else {
                                            controller.start();
                                          }
                                        },
                                        text: "Start Day",
                                        imagePath:
                                            "assets/images/timer_start.png",
                                        color: controller.startDay().value
                                            ? Colors.grey.shade500
                                            : primaryColor,
                                      ),
                                    ),
                                    Obx(() => controller.startDay().value
                                        ? Positioned(
                                            bottom: 20,
                                            child: Text(
                                              "( ${controller.lastSyncDate.value} )",
                                              style: GoogleFonts.roboto(
                                                  color: Colors.white),
                                            ))
                                        : const SizedBox())
                                  ],
                                ),
                              ),
                              //Planned Calls
                              HomeButton(
                                onTap: () async {
                                  if (controller.isDayStarted()) {
                                    bool isDataDownloaded = await _checkDataDownloaded();
                                    if (isDataDownloaded) {
                                      Get.toNamed(EdsRoutes.routes);
                                    }else{
                                      showToastMessage("Please download Data");
                                    }
                                  } else {
                                    showToastMessage(
                                        Constants.ERROR_DAY_NO_STARTED);
                                  }
                                },
                                text: "Planned Calls",
                                imagePath: "assets/images/planned_calls.png",
                                color: secondaryColor,
                              ),
                              //Download Data
                              HomeButton(
                                onTap: () {
                                  if (controller.isDayStarted()) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20),
                                        content: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Update Routes and Outlets!",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  "Are you sure you want to fetch updated routes and outlets?",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "NO",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      )),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        controller.download();
                                                      },
                                                      child: Text("YES",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    showToastMessage(
                                        Constants.ERROR_DAY_NO_STARTED);
                                  }
                                },
                                text: "Download",
                                iconData: Icons.cloud_download_rounded,
                                color: primaryColor,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // End Day
                              Expanded(
                                child: HomeButton(
                                  onTap: () => _onDayEndClick(),
                                  text: "End Day",
                                  imagePath: "assets/images/timer_end.png",
                                  color: secondaryColor,
                                ),
                              ),
                              //Download data
                              HomeButton(
                                onTap: () {
                                  if (controller.isDayStarted()) {
                                    _showReportsSelectionDialog(
                                      "Select Report",
                                      (object) {
                                        if (object.id == 0) {
                                          Get.toNamed(EdsRoutes.reports);
                                        } else {
                                          Get.toNamed(EdsRoutes.stock);
                                        }
                                      },
                                    );
                                  } else {
                                    showToastMessage(
                                        Constants.ERROR_DAY_NO_STARTED);
                                  }
                                },
                                text: "Reports",
                                imagePath: "assets/images/reports.png",
                                color: primaryColor,
                              ),
                              HomeButton(
                                onTap: () {
                                  if (controller.isDayStarted()) {
                                    Get.toNamed(EdsRoutes.upload);
                                  } else {
                                    showToastMessage(
                                        Constants.ERROR_DAY_NO_STARTED);
                                  }
                                },
                                text: "Upload",
                                iconData: Icons.cloud_upload,
                                color: secondaryColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 3,
                    child: Column(
                      children: [
                        Container(
                          color: primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.area_chart_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Target vs Achievement",
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Target Quantity"),
                              ),
                              Obx(
                                () => Text(_targetVsAchievement
                                    .value.targetAmount
                                    .toString()),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Achieved Quantity Percentage"),
                              ),
                              Obx(
                                () => Text(_targetVsAchievement
                                    .value.achievedQuantityPercentage
                                    .toString()),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Per Day Required Sale Quantity"),
                              ),
                              Obx(
                                () => Text(_targetVsAchievement
                                    .value.perDayRequiredSaleQuantity
                                    .toString()),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("MTD Sales"),
                              ),
                              Obx(
                                () => Text(_targetVsAchievement
                                    .value.mtdSaleQuantity
                                    .toString()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                  ))
            ],
          ),
          Obx(
            () => controller.isLoading().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void setObservers() {
/*
    debounce(controller.getRoutesLiveData(), (routesModel) {
      if (bool.parse(routesModel.success ?? "true")) {
        controller.deleteTables(true);
        controller.addDocuments(routesModel.documents);
        controller.addOutlets(routesModel.outlets);

//                if (syncCallback != null) {
//                    if (progressDialog != null)
//                        progressDialog.dismiss();
//                    syncCallback.onSync();
//                }

//                if (progressDialog != null)
//                    progressDialog.dismiss();
      } else {
        showToastMessage(routesModel.errorMessage.toString());
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getMessage(), (value) {
      showToastMessage(value.peekContent());
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getProgressMsg(), (value) {
      showToastMessage(value.peekContent());
    }, time: const Duration(milliseconds: 200));
*/

    debounce(controller.getTargetVsAchievement(), (aBoolean) {
      if (aBoolean) {
        setTargetVsAchievement(TargetVsAchievement.fromJson(
            jsonDecode(controller.getTargetVsAchievementData() ?? "")));
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.startDay(), (aBoolean) {
      if (aBoolean) {
        String startDate = Util.formatDate(
            Util.DATE_FORMAT_3, controller.getWorkSyncData().syncDate);

        controller.setSyncDate(startDate);

        //Day started message dialog
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  insetPadding: const EdgeInsets.all(20),
                  title: Text(
                    "Day Started! ( $startDate )",
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your day has been started",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Ok",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 16),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
      } else {
        WorkStatus status = WorkStatus(0);
        controller.saveWorkSyncData(status);
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getEndDayLiveData(), (aBoolean) {
      if (aBoolean) {
        controller.setLoading(false);
        String endDate = Util.formatDate(
            Util.DATE_FORMAT_3, controller.getWorkSyncData().syncDate);

        //Day End Confirmation dialog
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  insetPadding: const EdgeInsets.all(20),
                  title: Text(
                    "Day Closing! ( $endDate )",
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Are you sure you want to end your day? After ending your day you will not be able to take any Survey",
                        style: GoogleFonts.roboto(fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text(
                                "No",
                                style: GoogleFonts.roboto(color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                controller.updateDayEndStatus();
                              },
                              child: Text(
                                "Yes",
                                style: GoogleFonts.roboto(color: Colors.black),
                              )),
                        ],
                      )
                    ],
                  ),
                ));
      }
    }, time: const Duration(milliseconds: 200));
  }

  Future<void> _onDayEndClick() async {
    controller.setLoading(true);
    if (!controller.isDayStarted()) {
      controller.setLoading(false);
      showToastMessage(Constants.ERROR_DAY_NO_STARTED);
      return;
    }

    final int pendingOrderCount = await controller.getUnPostedOrderCount();
    if (pendingOrderCount > 0) {
      controller.setLoading(false);
      showToastMessage("Please upload all the Orders before Day end!");
      return;
    }

    List<Outlet> outletList = await controller.findAllOutlets();

    if (outletList.isNotEmpty) {
      final List<Outlet> outlets =
          await controller.findOutletsWithPendingTasks();

      if (outlets.isNotEmpty && controller.getEndDayOnPjpCompletion()) {
        controller.setLoading(false);
        showToastMessage("Please complete your tasks");
      } else if (controller.getConfig() != null) {
        controller.setEndDayLiveData(true);
      }
    }
  }

  void init() {
    if (controller.getTargetVsAchievementData() != null) {
      setTargetVsAchievement(TargetVsAchievement.fromJson(
          jsonDecode(controller.getTargetVsAchievementData() ?? "")));
    }
  }

  void setTargetVsAchievement(TargetVsAchievement targetVsAchievement) {
    _targetVsAchievement(targetVsAchievement);
    _targetVsAchievement.refresh();
  }

  void _showReportsSelectionDialog(
      String title, Function(CustomObject) mListener) {
    List<CustomObject> mList = [];
    mList.add(CustomObject(0, "KPI Reports"));
    mList.add(CustomObject(1, "Stock Reports"));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        insetPadding: const EdgeInsets.all(20),
        title: Text(
          title,
          style: GoogleFonts.roboto(color: Colors.black87),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    mListener(mList[0]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          mList[0].text,
                          style: GoogleFonts.roboto(
                              color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    mListener(mList[1]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          mList[1].text,
                          style: GoogleFonts.roboto(
                              color: Colors.black87, fontSize: 16),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkDataDownloaded() async {
    int priceConditionClass = await controller.priceConditionClassValidation();
    int priceCondition = await controller.priceConditionValidation();
    int priceConditionType = await controller.priceConditionTypeValidation();

    if (priceConditionClass != 0 &&
        priceCondition != 0 &&
        priceConditionType != 0) {
      return true;
    } else {
      return false;
    }
  }
}
