import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:order_booking/components/dialog/promo_dialog/promo_dialog.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';
import 'package:order_booking/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/navigation_drawer/my_navigation_drawer.dart';
import '../../../../components/progress_dialog/PregressDialog.dart';
import '../../../../db/entities/outlet/outlet.dart';
import '../../../../db/entities/promotion/promotion.dart';
import '../../../../utils/Colors.dart';
import '../../../../utils/PreferenceUtil.dart';
import '../../../../utils/utils.dart';
import 'outlet_detail_view_model.dart';

class OutletDetailScreen extends StatefulWidget {
  const OutletDetailScreen({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 10);

  @override
  State<OutletDetailScreen> createState() => _OutletDetailScreenState();
}

class _OutletDetailScreenState extends State<OutletDetailScreen> {
  late GoogleMapController _controller;

  LatLng? outletLatLng, currentLatLng;

  int statusId = 1;

  int startLocationTime = 0;

  int endLocationTime = 0;

  int alertDialogCount = 0;

  bool isFakeLocation = false;

  int? notFlowReasonCode;

  final OutletDetailViewModel controller =
  Get.put(OutletDetailViewModel(OutletDetailRepository(Get.find(),Get.find())));

  late final int outletId;

  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      outletId = args[0];
    } else {
      outletId = 0;
    }
    controller.loadSelectedOutlet(outletId);
    // setObservers();
    _setLocationCallback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Expanded(
              child: Text(
                "EDS",
                style: GoogleFonts.roboto(color: Colors.white),
              ))),
      body: FutureBuilder(
        future: controller.loadSelectedOutlet(outletId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: Obx(
                                  () =>
                                  GoogleMap(
                                    initialCameraPosition:
                                    OutletDetailScreen._initialCameraPosition,
                                    scrollGesturesEnabled: false,
                                    markers: controller.markers.value,
                                    zoomControlsEnabled: false,
                                    mapToolbarEnabled: false,
                                    mapType: MapType.normal,
                                    onMapCreated: (mapController) async {
                                      _controller = mapController;
                                      // final Uint8List? markerIcon = await Utils.getBytesFromAsset('assets/images/ic_location.png', 100);
                                      if (controller.outlet.latitude != null &&
                                          controller.outlet.longitude != null) {
                                        controller.addMarker(Marker(
                                          markerId: const MarkerId("location"),
                                          position: LatLng(
                                              controller.outlet.latitude!,
                                              controller.outlet.longitude!),
                                        ));
                                        _controller.animateCamera(
                                            CameraUpdate.newLatLngZoom(
                                                LatLng(
                                                    controller.outlet.latitude!,
                                                    controller.outlet
                                                        .longitude!),
                                                15));
                                      }
                                    },
                                  ),
                            )),
                        Positioned(
                          bottom: 5.0,
                          right: 5.0,
                          child: IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.locationArrow,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              try {
                                launchMapUrl();
                              } catch (e) {
                                showToastMessage(e.toString());
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name: ",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Address: ",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Channel: ",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Number of Assets: ",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Digital Account: ",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Disburse Amount",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Remarks",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.outlet.outletName ??
                                                "outlet name",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            controller.outlet.address ??
                                                "outlet address",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            controller.outlet.channelName ??
                                                "channel name",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            controller.outlet.outletCode ??
                                                "no of assets",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            controller.outlet.digitalAccount ??
                                                "digital account",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "${controller.outlet
                                                .disburseAmount ?? 0.0}",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            controller.outlet.remarks ??
                                                "Remarks",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "MTD Sales",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Month to Date Sales: ${controller
                                              .outlet.lastSale ?? 0.0}",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black54,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last Order",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rs : ${controller.outlet.lastOrder
                                              ?.orderTotal ?? 0.0}",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black54,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Quantity : ${controller.outlet
                                              .lastOrder?.orderQuantity ??
                                              0.0}",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black54,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Taken on : ${Util.formatDate(
                                              Util.DATE_FORMAT_1,
                                              controller.outlet.lastOrder
                                                  ?.lastSaleDate)}",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black54,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      onPromotionsClick();
                                    },
                                    child: Container(
                                      color: Colors.blueAccent,
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        "Promotions",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                              return ['Outlet Closed', 'No Time']
                                  .map((String item) {
                                return PopupMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(item),
                                  ),
                                );
                              }).toList();
                            },
                            onSelected: (selectedReason) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(5))),
                                      insetPadding: const EdgeInsets.all(20),
                                      title: const Text("Warning!"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Are you sure you want to take an action?",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Text(
                                                    "No",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,fontSize: 16),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Map<String, int> hashMap = {
                                                    };
                                                    hashMap['Outlet Closed'] =
                                                    2;
                                                    hashMap['No Time'] = 3;

                                                    notFlowReasonCode =
                                                    hashMap[selectedReason];
                                                    Navigator.of(context).pop();
                                                    notFlowClick();
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,fontSize: 16),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                              );
                            },
                            offset: const Offset(0, -120),
                            child: Container(
                              color: Colors.blueAccent,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "CAN'T START FLOW",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ), // Adjust the vertical offset as needed
                          ),
                          InkWell(
                            onTap: () => onStartFlowClick(),
                            child: Container(
                              color: Colors.blueAccent,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "START FLOW",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Obx(
                      () =>
                  controller
                      .isLoading()
                      .value
                      ? const SimpleProgressDialog()
                      : const SizedBox(),
                ),
              ],
            );
          } else {
            return const SimpleProgressDialog();
          }
        },
      ),
    );
  }

  void onStartFlowClick() {
    PreferenceUtil preferenceUtil = Get.find<PreferenceUtil>();
    preferenceUtil.setOutletStatus(1);

    if (!isFakeLocation) {
      //TODO-add auto time check here, if not auto time then show dialog message and return
      bool autoTime = true;
      if (!autoTime) {
        return;
      }
      controller.updateOutletStatusCode(1);

      if (currentLatLng != null) {
        final outletVisitStartTime = DateTime.now().millisecondsSinceEpoch;

        controller.onNextClick(currentLatLng!,outletVisitStartTime);
      } else {
        _setLocationCallback();
      }
    } else {
      showToastMessage("You are using fake GPS");
    }
  }

  void notFlowClick() async {
    if (!isFakeLocation) {
      bool isAutoTimeEnabled = await _checkAutoTime();

      // if (!isAutoTimeEnabled && !controller.isTestUser()) {
      //   //TODO-show dialog message
      //   showToastMessage("Please enable auto date time");
      //   return;
      // }
      controller.updateOutletStatusCode(1);

      if (currentLatLng != null) {
        // controller.onStartNotFlow(currentLatLng!);
      } else {
        _setLocationCallback();
      }
    } else {
      showToastMessage("You are using fake GPS");
    }
  }

  Future<bool> _checkAutoTime() async {
    const platform = MethodChannel('com.optimus.time/autoTime');

    bool isAutoTimeEnabled;
    try {
      final bool result = await platform.invokeMethod('isAutoDateTimeEnabled');
      isAutoTimeEnabled = result;
    } on PlatformException catch (e) {
      isAutoTimeEnabled = false;
    } on Exception catch (e) {
      e.printInfo();
      isAutoTimeEnabled = false;
    }

    return isAutoTimeEnabled;
  }

  Future<LocationData> _setLocationCallback() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location service not enabled");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permissions are denied");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request permissions. ");
    }
    // controller.setLoading(true);
    final locationData = await Location.instance.getLocation();
    isFakeLocation = locationData.isMock ?? false;

    // controller.setLoading(false);
    if (locationData.latitude != null && locationData.longitude != null) {
      currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);
    }

    if (controller.outlet.latitude != null &&
        controller.outlet.longitude != null) {
      outletLatLng =
          LatLng(controller.outlet.latitude!, controller.outlet.longitude!);
    }

    // controller.setLoading(true);
    // double meters = Util.checkMetre(currentLatLng, outletLatLng);

    // Configuration configuration = controller.getConfiguration();

    startLocationTime = DateTime
        .now()
        .millisecondsSinceEpoch;
    // if ((meters > configuration.geoFenceMinRadius &&
    //         startLocationTime > endLocationTime) &&
    //     !controller.isTestUser()) {
    //   showOutsideBoundaryDialog(alertDialogCount, meters.toString());
    // } else if (meters <= configuration.geoFenceMinRadius ||
    //     !controller.isTestUser()) {
    //   controller.updateBtn(true);
    // }

    return locationData;
  }

  void launchMapUrl() async {
    String url =
        "https://www.google.com/maps/dir/?api=1&destination=${controller.outlet
        .latitude},${controller.outlet.longitude}";
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void showOutsideBoundaryDialog(int repeat, String distance) {
    if (repeat < 2) {
      alertDialogCount++;
      // showToastMessage(
      //     "Your are $distance away from the outlet please go to outlet location and try again");

      // controller.setLoading(true);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              insetPadding: const EdgeInsets.all(20),
              title: Text("Warning!", style: GoogleFonts.roboto()),
              content: Text(
                "You are $distance away from the retailer's defined boundary.\nPress Ok to continue" +
                    "\nCurrent LatLng ::  ${currentLatLng
                        ?.latitude} , ${currentLatLng
                        ?.longitude} \nAlert Count :: ${repeat + 1}",
                style: GoogleFonts.roboto(),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _setLocationCallback();
                    },
                    child: Text(
                      "Ok",
                      style: GoogleFonts.roboto(color: Colors.grey.shade800,fontSize: 16),
                    ))
              ],
            ),
      );
    }
  }

  void onPromotionsClick() {
    controller.getPromotions(outletId).then(
          (promotions) {
        if (promotions.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              // List<Promotion> promos = [
              //   Promotion(name: "Promotion 1", amount: 100),
              //   Promotion(name: "Promotion 2", amount: 140.22),
              //   Promotion(name: "Promotion 3", amount: 300.0),
              //   Promotion(name: "Promotion 4", amount: 10.0),
              //   Promotion(name: "Promotion 5", amount: 130.0),
              //   Promotion(name: "Promotion 6", amount: 130.0),
              // ];
              return PromotionDialog(promos: promotions);
            },
          );
        } else {
          showToastMessage("No Promotions");
        }
      },
    );
  }

//
// void setObservers() {
//   debounce(controller.isStartFlow, (value) {
//     if (value) {
//       startFlowToNext();
//     }
//   }, time: const Duration(milliseconds: 200));
//
//   debounce(controller.isStartNotFlow, (value) {
//     if (value) {
//       // setStartNotFlow();
//     }
//   }, time: const Duration(milliseconds: 200));
//
//   debounce(controller.outletNearbyPos, (distance) {
//     if (currentLatLng != null && outletLatLng != null) {
//       AlertDialogManager.getInstance()
//           .showLocationMissMatchAlertDialog(context,currentLatLng!, outletLatLng!);
//     }
//   }, time: const Duration(milliseconds: 200));
//
//   debounce(controller.getSurveySavedWithEvent(), (event) {
//     if (event.getContentIfNotHandled() != null) {
//       controller.setOutletStatus(1);
//       // navigate back to outlet list screen
//       // Get.back(result: "ok");
//       Get.until((route) => Get.currentRoute == Routes.outletList);
//       SurveySingletonModel.getInstance().reset();
//     }
//   }, time: const Duration(milliseconds: 200));
//
//   debounce(controller.getPostWorkWithSaved(), (aBoolean) {
//     if (aBoolean) {
//       controller.setOutletStatus(1);
//       // navigate back to outlet list screen
//       // Get.back(result: "ok");
//       Get.until((route) => Get.currentRoute == Routes.outletList);
//       WorkWithSingletonModel.getInstance().reset();
//     }
//   }, time: const Duration(milliseconds: 100));
//
//   debounce(controller.getMessage(), (event) {
//     showToastMessage(event.peekContent());
//   }, time: const Duration(milliseconds: 200));
// }
}
