import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:order_booking/components/button/cutom_button.dart';
import 'package:order_booking/components/progress_dialog/PregressDialog.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/route/outlet/merchandising/asset_verification/asset_verification_list_item.dart';
import 'package:order_booking/ui/route/outlet/merchandising/asset_verification/asset_verification_view_model.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:order_booking/utils/utils.dart';

import '../../../../../db/entities/asset/asset.dart';
import '../../../../../utils/Colors.dart';

class AssetVerificationScreen extends StatefulWidget {
  const AssetVerificationScreen({super.key});

  @override
  State<AssetVerificationScreen> createState() =>
      _AssetVerificationScreenState();
}

class _AssetVerificationScreenState extends State<AssetVerificationScreen> {
  final AssetVerificationViewModel controller =
      Get.put<AssetVerificationViewModel>(
          AssetVerificationViewModel(Get.find(), Get.find()));

  late final int _outletId;

  LatLng? currentLatLng;

  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      _outletId = args[0];
    } else {
      _outletId = 0;
    }

    _init();
    _setLocationCallback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) => _onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              title: Text(
                "Asset Verification",
                style: GoogleFonts.roboto(color: Colors.white),
              )),
          body: Stack(
            children: [
              Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    elevation: 3,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Text(
                              "Asset Code",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text(
                              "Verification",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 14,
                            child: Text(
                              "Status",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Obx(
                    () => ListView.builder(
                      itemBuilder: (context, index) {
                        return AssetVerificationListItem(
                          asset: controller.assetList[index],
                          assetStatuses: controller.assetStatuses,
                        );
                      },
                      itemCount: controller.assetList.length,
                    ),
                  )),
                  CustomButton(
                      onTap: () async {
                        // _startBarcodeScan();
                        // final result = await Get.toNamed(EdsRoutes.barcodeScanner,
                        //     arguments: [_outletId]);
                        // showToastMessage(result.toString());
                      },
                      text: "Barcode Scan")
                ],
              ),
              Obx(
                () => controller.isLoading.value
                    ? const SimpleProgressDialog()
                    : const SizedBox(),
              )
            ],
          ),
        ));
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

    controller.setLoading(true);
    final locationData = await Location.instance.getLocation();

    if (locationData.latitude != null && locationData.longitude != null) {
      currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);
    }

    controller.setLoading(false);
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

  // Future<void> _startBarcodeScan() async {
  //   try {
  //     final scanResult = await Get.to(const SimpleBarcodeScannerPage());
  //     if (!mounted) return;
  //
  //     showToastMessage("Barcode Scanned ( $scanResult )");
  //     controller.verifyAsset(scanResult, currentLatLng);
  //     controller.setAssetScanned(true);
  //   } catch (e) {
  //     setState(() {
  //       showToastMessage("Failed to get barcode.");
  //     });
  //   }
  // }

  void _init() {
    controller.loadOutlet(_outletId);
    controller.getLookUpData();
    controller.loadAssets(_outletId);
  }

  void _onBackPressed() {
    int verified = 0, notVerified = 0, statusWithOutVerified = 0;
    if (controller.assetList.isNotEmpty) {
      for (Asset asset in controller.assetList) {
        if (asset.statusid != null && asset.getVerified()) {
          verified++;
        } else if (asset.statusid != null) {
          notVerified++;
        } else {
          statusWithOutVerified++;
        }
      }
    }

    controller.setAssetVerifiedCount(verified);

    if (statusWithOutVerified > 0) {
      if (controller.getAssetScannedInLastMonth()) {
        Get.back();
        return;
      }

      controller.setAssetsScannedInLastMonth(false);
      controller.setAssetsScannedWithoutVerified(true);
    } else if (notVerified > 0) {
      if (controller.getAssetScannedInLastMonth()) {
        Get.back();
        return;
      }

      controller.setAssetsScannedInLastMonth(false);
      controller.setAssetsScannedWithoutVerified(false);
    } else if (verified == controller.assetList.length) {
      controller.setAssetsScannedInLastMonth(true);
      controller.setAssetsScannedWithoutVerified(true);
    }
    Get.back();
  }
}
