import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/components/navigation_drawer/MyNavigationDrawer.dart';
import 'package:order_booking/ui/home/home_view_model.dart';
import 'package:order_booking/utils/Colors.dart';

import '../../components/button/HomeButton.dart';
import '../../utils/Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel controller = Get.put(HomeViewModel());

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
      body: Column(
        children: [
          Expanded(
              flex: 5,
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
                              HomeButton(
                                onTap: () {
                                  // if (controller.startDay().value) {
                                  //   return null;
                                  // } else {
                                  //   controller.start();
                                  // }
                                },
                                text: "Start Day",
                                iconData: Icons.alarm,
                                color: /*controller.startDay().value
                              ? Colors.grey.shade500
                              :*/
                                    primaryColor,
                              ),
                              // Obx(() => controller.startDay().value
                              //     ? Positioned(
                              //     bottom: 20,
                              //     child: Text(
                              //       "( ${controller.lastSyncDate.value} )",
                              //       style: GoogleFonts.roboto(
                              //           color: Colors.white),
                              //     ))
                              //     : const SizedBox())
                            ],
                          ),
                        ),
                        //Download data
                        HomeButton(
                          onTap: () {
                            // if (controller.isDayStarted()) {
                            //   controller.download();
                            // } else {
                            //   showToastMessage(Constants.ERROR_DAY_NO_STARTED);
                            // }
                          },
                          text: "Planned Calls",
                          iconData: Icons.phone_android_rounded,
                          color: secondaryColor,
                        ),
                        HomeButton(
                          onTap: () {
                            // if (controller.isDayStarted()) {
                            //   controller.download();
                            // } else {
                            //   showToastMessage(Constants.ERROR_DAY_NO_STARTED);
                            // }
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
                        // Start Day
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomCenter,
                            children: [
                              HomeButton(
                                onTap: () {
                                  // if (controller.startDay().value) {
                                  //   return null;
                                  // } else {
                                  //   controller.start();
                                  // }
                                },
                                text: "End Day",
                                iconData: Icons.alarm_off_sharp,
                                color: /*controller.startDay().value
                              ? Colors.grey.shade500
                              :*/
                                    secondaryColor,
                              ),
                              // Obx(() => controller.startDay().value
                              //     ? Positioned(
                              //     bottom: 20,
                              //     child: Text(
                              //       "( ${controller.lastSyncDate.value} )",
                              //       style: GoogleFonts.roboto(
                              //           color: Colors.white),
                              //     ))
                              //     : const SizedBox())
                            ],
                          ),
                        ),
                        //Download data
                        HomeButton(
                          onTap: () {
                            // if (controller.isDayStarted()) {
                            //   controller.download();
                            // } else {
                            //   showToastMessage(Constants.ERROR_DAY_NO_STARTED);
                            // }
                          },
                          text: "Reports",
                          iconData: Icons.file_open_rounded,
                          color: primaryColor,
                        ),
                        HomeButton(
                          onTap: () {
                            // if (controller.isDayStarted()) {
                            //   controller.download();
                            // } else {
                            //   showToastMessage(Constants.ERROR_DAY_NO_STARTED);
                            // }
                          },
                          text: "Upload",
                          iconData: Icons.cloud_upload,
                          color: secondaryColor,
                        )
                      ],
                    ),
                  ),
                ],
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
                              style: GoogleFonts.roboto(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Key One"),
                        ), Text("Key One value")],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Key Two"),
                        ), Text("Key Two value")],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Key Three"),
                        ), Text("Key Three value")],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Key four"),
                        ), Text("Key four value")],
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
    );
  }
}
