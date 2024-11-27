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
import 'package:order_booking/components/dialog/last_order_dialog/last_order_dialog.dart';
import 'package:order_booking/components/dialog/promo_dialog/promo_dialog.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/home/home_view_model.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:order_booking/utils/device_info_util.dart';
import 'package:order_booking/utils/network_manager.dart';
import 'package:order_booking/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../components/navigation_drawer/my_navigation_drawer.dart';
import '../../../../components/progress_dialog/PregressDialog.dart';
import '../../../../db/entities/outlet/outlet.dart';
import '../../../../db/entities/promotion/promotion.dart';
import '../../../../db/models/configuration/configurations.dart';
import '../../../../db/models/outlet_visit/outlet_visit.dart';
import '../../../../utils/AlertDialogManager.dart';
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
  late GoogleMapController _mapController;

  LatLng? _outletLatLng, _currentLatLng;

  int _statusId = 1;

  int _startLocationTime = 0;

  int _endLocationTime = 0;

  int _alertDialogCount = 0;

  bool _isFakeLocation = false;

  int? _notFlowReasonCode=1;

  final OutletDetailViewModel _controller = Get.put(OutletDetailViewModel(
      OutletDetailRepository(
          Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
      Get.find()));

  final _homeController = Get.find<HomeViewModel>();

  late final int _outletId;

  final bool _enableMerchandise = true;

  String _reasonForNoSale = "";

  int _outletVisitStartTime = DateTime.now().millisecondsSinceEpoch;
  bool _withoutVerification = false;

  final RxString _tvAssetsNumber = "".obs;
  final RxBool _enableBtn = false.obs;
  bool _isAssets = false;

  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      _outletId = args[0];
    } else {
      _outletId = 0;
    }
    _controller.setAssetScanned(false);
    _controller.loadSelectedOutlet(_outletId);
    _setObservers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "OUTLET DETAILS",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: FutureBuilder(
        future: _controller.loadSelectedOutlet(_outletId),
        builder: (context, snapshot) {
          _controller.setLoading(true);
          _setLocationCallback();
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
                              () => GoogleMap(
                                initialCameraPosition:
                                    OutletDetailScreen._initialCameraPosition,
                                scrollGesturesEnabled: false,
                                markers: _controller.markers.value,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                                mapType: MapType.normal,
                                onMapCreated: (mapController) async {
                                  _mapController = mapController;
                                  // final Uint8List? markerIcon = await Utils.getBytesFromAsset('assets/images/ic_location.png', 100);
                                  if (_controller.outlet.latitude != null &&
                                      _controller.outlet.longitude != null) {
                                    _controller.addMarker(Marker(
                                      markerId: const MarkerId("location"),
                                      position: LatLng(
                                          _controller.outlet.latitude!,
                                          _controller.outlet.longitude!),
                                    ));
                                    _mapController.animateCamera(
                                        CameraUpdate.newLatLngZoom(
                                            LatLng(_controller.outlet.latitude!,
                                                _controller.outlet.longitude!),
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
                                _launchMapUrl();
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Name: ",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "${_controller.outlet.outletName}-${_controller.outlet.location}" ??
                                                "outlet name",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Address: ",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            _controller.outlet.address ??
                                                "outlet address",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Channel: ",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            _controller.outlet.channelName ??
                                                "channel name",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "No Of Assets: ",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Obx(
                                            () => Text(
                                              _tvAssetsNumber.value,
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Digital Account: ",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            _controller.outlet.digitalAccount ??
                                                "digital account",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Disburse Amount: ",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "${_controller.outlet.disburseAmount ?? 0.0}",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Remarks: ",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            _controller.outlet.remarks ??
                                                "Remarks",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Month to Date Sales: ${_controller.outlet.lastSale ?? 0.0}",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.normal),
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
                              child: InkWell(
                                onTap: () => _showLastOrderDialog(),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            "Rs. ${_controller.outlet.lastOrder?.orderTotal ?? 0.0}",
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
                                            "Quantity : ${_controller.outlet.lastOrder?.orderQuantity ?? 0.0}",
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
                                            "Taken on : ${Util.formatDate(Util.DATE_FORMAT, _controller.outlet.lastOrder?.lastSaleDate)}",
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
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 150,
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      _onPromotionsClick();
                                    },
                                    child: Container(
                                      color: Colors.blueAccent,
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        "Promotions",
                                        textAlign: TextAlign.center,
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
                          Obx(
                            () => PopupMenuButton(
                              enabled: _enableBtn.value,
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
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    insetPadding: const EdgeInsets.all(20),
                                    title: const Text("Warning!"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Are you sure you want to take an action?",
                                          style:
                                              GoogleFonts.roboto(fontSize: 16),
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
                                                    Navigator.of(context).pop(),
                                                child: Text(
                                                  "No",
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  Map<String, int> hashMap = {};
                                                  hashMap['Outlet Closed'] = 2;
                                                  hashMap['No Time'] = 3;

                                                  _notFlowReasonCode =
                                                      hashMap[selectedReason];
                                                  Navigator.of(context).pop();
                                                  _notFlowClick();
                                                },
                                                child: Text(
                                                  "Yes",
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              offset: const Offset(0, -120),
                              child: Opacity(
                                opacity: _enableBtn.value ? 1.0 : 0.5,
                                child: Container(
                                  color: Colors.blueAccent,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "CAN'T START FLOW",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ), // Adjust the vertical offset as needed
                            ),
                          ),
                          Obx(
                            () => InkWell(
                              onTap: _enableBtn.value
                                  ? () => _onStartFlowClick()
                                  : null,
                              child: Opacity(
                                opacity: _enableBtn.value ? 1.0 : 0.5,
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
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Obx(
                  () => _controller.isLoading().value
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

  Future<void> _onStartFlowClick() async {
    PreferenceUtil preferenceUtil = Get.find<PreferenceUtil>();
    preferenceUtil.setOutletStatus(1);

    if (!_isFakeLocation) {
      //check auto time and date enabled if not show message
      bool isAutoTimeEnabled = await DeviceInfoUtil.isAutoTimeEnabled();

      if (!isAutoTimeEnabled && !_controller.isTestUser()) {
        //ask user to enable auto date and time
        _showAutoTimeWarningDialog();
        return;
      }

      _outletVisitStartTime = DateTime.now().millisecondsSinceEpoch;
      bool isMatched = Util.isCurrentDateMatched(_controller.getSyncDate());
      if (!isMatched && !_controller.isTestUser()) {
        _showWarningDialogue(
            "Your System Date Time doesn't match with Day Start");
        return;
      }

      bool isDeveloperOptionEnable = false;

      // bool isDeveloperOptionEnable =
      //     await DeviceInfoUtil.isDeveloperOptionsEnabled();
      if (isDeveloperOptionEnable && !_controller.isTestUser()) {
        _showWarningDialogue(
            "Your developer option is enable in mobile setting!\nPlease turn off the developer Option.");
        return;
      }

      _controller.updateOutletStatusCode(1);

      if (_currentLatLng != null) {
        final outletVisitStartTime = DateTime.now().millisecondsSinceEpoch;

        _controller.onNextClick(_currentLatLng!, outletVisitStartTime);
      } else {
        _controller.setLoading(true);
        _setLocationCallback();
      }
    } else {
      showToastMessage("You are using fake GPS");
    }
  }

  void _notFlowClick() async {
    if (!_isFakeLocation) {
      bool isAutoTimeEnabled = await DeviceInfoUtil.isAutoTimeEnabled();

      if (!isAutoTimeEnabled && !_controller.isTestUser()) {
        //show to dialog to ask user to enable auto time
        _showAutoTimeWarningDialog();
        return;
      }
      _controller.updateOutletStatusCode(_notFlowReasonCode??1);

      if (_currentLatLng != null) {
        _controller.onNextClick(_currentLatLng!, _outletVisitStartTime);
      } else {
        _controller.setLoading(true);
        _setLocationCallback();
      }
    } else {
      showToastMessage("You are using fake GPS");
    }
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
    final locationData = await Location.instance.getLocation();
    _isFakeLocation = locationData.isMock ?? false;

    if (locationData.latitude != null && locationData.longitude != null) {
      _currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);
    }

    if (_controller.outlet.latitude != null &&
        _controller.outlet.longitude != null) {
      _outletLatLng =
          LatLng(_controller.outlet.latitude!, _controller.outlet.longitude!);
    }

    // controller.setLoading(true);
    double meters = Util.checkMetre(_currentLatLng, _outletLatLng);

    ConfigurationModel configuration = _controller.getConfiguration();

    _startLocationTime = DateTime.now().millisecondsSinceEpoch;
    if ((meters > configuration.geoFenceMinRadius &&
            _startLocationTime > _endLocationTime) &&
        !_controller.isTestUser()) {
      _controller.setLoading(false);
      _showOutsideBoundaryDialog(_alertDialogCount, meters.toString());
    } else if (meters <= configuration.geoFenceMinRadius ||
        _controller.isTestUser()) {
      _controller.setLoading(false);
      _updateBtn(true);
    }

    return locationData;
  }

  void _updateBtn(bool value) {
    _enableBtn.value = value;
    _enableBtn.refresh();
  }

  void _launchMapUrl() async {
    String url =
        "https://www.google.com/maps/dir/?api=1&destination=${_controller.outlet.latitude},${_controller.outlet.longitude}";
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void _showOutsideBoundaryDialog(int repeat, String distance) {
    if (repeat < 2) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          insetPadding: const EdgeInsets.all(20),
          title: Text("Warning!", style: GoogleFonts.roboto()),
          content: Text(
            "You are $distance away from the retailer's defined boundary.\nPress Ok to continue" +
                "\nCurrent LatLng ::  ${_currentLatLng?.latitude} , ${_currentLatLng?.longitude} \nAlert Count :: ${repeat + 1}",
            style: GoogleFonts.roboto(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _alertDialogCount++;
                  _startLocationTime = DateTime.now().millisecondsSinceEpoch;
                  _endLocationTime = _startLocationTime;
                  _controller.setLoading(true);
                  _setLocationCallback();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Ok",
                  style: GoogleFonts.roboto(
                      color: Colors.grey.shade800, fontSize: 16),
                ))
          ],
        ),
      );
    } else {
      OutletVisit outletVisit = OutletVisit();
      outletVisit.outletId = _outletId;
      outletVisit.visitTime = _outletVisitStartTime;
      outletVisit.latitude = _outletLatLng?.latitude;
      outletVisit.longitude = _outletLatLng?.longitude;
      _controller.outlet.outletVisits?.add(outletVisit);
      _controller.updateOutlet(_controller.outlet);
      _updateBtn(true);
    }
  }

  void _onPromotionsClick() {
    _controller.getPromotions(_outletId).then(
      (promotions) {
        if (promotions.isNotEmpty) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return PromotionDialog(promos: promotions);
            },
          );
        } else {
          showToastMessage("No Promotions");
        }
      },
    );
  }

  void _setObservers() {
    debounce(_controller.getUploadStatus(), (aBoolean) async {
      if (aBoolean) {
        double outletDistance = Util.checkMetre(_currentLatLng, _outletLatLng);
        _controller.uploadStatus(
            _outletId,
            _currentLatLng,
            _outletLatLng,
            outletDistance,
            _outletVisitStartTime,
            DateTime.now().millisecondsSinceEpoch,
            _reasonForNoSale);
      } else {
        if (_enableMerchandise) {
          Get.toNamed(EdsRoutes.outletMerchandising, arguments: [_outletId])
              ?.then(
            (result) {
              if(result!=null&&result[Constants.STATUS_OK]) {
                _handleResult(result);
              }
            },
          );
        } else {
          Get.toNamed(EdsRoutes.orderBooking, arguments: [_outletId])?.then(
            (result) {
              if(result!=null&&result[Constants.STATUS_OK]) {
                _handleResult(result);
              }
            },
          );
        }

//                finish();
      }
    }, time: const Duration(milliseconds: 200));

    debounce(_controller.getAssets(_outletId), (assets) {
      _tvAssetsNumber(assets.length.toString());
      _tvAssetsNumber.refresh();
      _isAssets = assets.isNotEmpty;
    }, time: const Duration(milliseconds: 200));

    debounce(_controller.getSingleOrderUpdate(), (outletId) {
      if (outletId != 0) {
        NetworkManager.getInstance().isConnectedToInternet().then(
          (aBoolean) async {
            if (aBoolean) {
              WakelockPlus.enable();
              String? msg = await _homeController.uploadSingleOrder(outletId);

              _controller.setLoading(false);
              if (msg != null && msg.isNotEmpty) {
                showToastMessage(msg.toString());
              }

              Get.back();
            } else {
              showToastMessage("No Internet Connection");
              Get.back();
            }
          },
        );
      }
    }, time: const Duration(milliseconds: 100));

    debounce(_controller.outletNearbyPos, (distance) {
      if (_currentLatLng != null && _outletLatLng != null) {
        AlertDialogManager.getInstance().showLocationMissMatchAlertDialog(
            context, _currentLatLng!, _outletLatLng!);
      }
    }, time: const Duration(milliseconds: 200));
  }

  void _showLastOrderDialog() {
    if (_controller.outlet.lastOrder != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            LastOrderDialog(order: _controller.outlet.lastOrder),
      );
    }
  }

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

  void _showWarningDialogue(String message) {
    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          insetPadding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          title: const Text("Error"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
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
                          "Ok",
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

  void _handleResult(Map<String, dynamic>? result) {
    if (result != null &&
        result.keys.contains(Constants.EXTRA_PARAM_NO_ORDER_FROM_BOOKING)) {
      bool noOrderFromOrderBooking =
          result[Constants.EXTRA_PARAM_NO_ORDER_FROM_BOOKING] ?? false;
      _withoutVerification = result[Constants.WITHOUT_VERIFICATION] ?? false;
      // _reasonForNoSale =
      //     result[Constants.EXTRA_PARAM_OUTLET_REASON_N_ORDER] ?? false;
      if (!_withoutVerification) {
        // showProgress();
        _controller.postEmptyCheckout(noOrderFromOrderBooking, _outletId,
            _outletVisitStartTime, DateTime.now().millisecondsSinceEpoch);
//                            viewModel.scheduleMerchandiseJob(getApplication(), outletId, PreferenceUtil.getInstance(getApplication()).getToken());
      } else {
        _controller.postEmptyCheckoutWithOutAssetVerification(
            noOrderFromOrderBooking,
            _outletId,
            _outletVisitStartTime,
            DateTime.now().millisecondsSinceEpoch);
      }
    }
    else {
      Get.back();
    }
  }
}
