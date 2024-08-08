import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_booking/db/models/merchandise_images/merchandise_image.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/asset_verification/asset_verification_screen.dart';
import 'package:order_booking/ui/route/outlet/merchandising/planogram/image_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

import '../../../../components/button/cutom_button.dart';
import '../../../../components/navigation_drawer/my_navigation_drawer.dart';
import '../../../../components/progress_dialog/PregressDialog.dart';
import '../../../../db/entities/asset/asset.dart';
import '../../../../utils/Colors.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/utils.dart';
import 'asset_verification/asset_verification_screen.dart';
import 'merchandising_view_model.dart';
import 'merchandising_list_item.dart';

class MerchandisingScreen extends StatefulWidget {
  const MerchandisingScreen({super.key});

  @override
  State<MerchandisingScreen> createState() => _MerchandisingScreenState();
}

class _MerchandisingScreenState extends State<MerchandisingScreen> with WidgetsBindingObserver{
  final MerchandisingViewModel controller =
      Get.put(MerchandisingViewModel(Get.find(), Get.find()));

  final TextEditingController _remarksController = TextEditingController();

  bool isAssets = true;
  bool assetsVerified = true;

  final RxBool _disableAssetScanningBtn = false.obs;

  late final int outletId;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state==AppLifecycleState.resumed){
      controller.getAssets(outletId);
    }
    super.didChangeAppLifecycleState(state);
  }
  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      outletId = args[0];
    } else {
      outletId = 0;
    }

    controller.loadOutlet(outletId);
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
            "Merchandising",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 2, right: 2),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "OutletName: ",
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 10,
                              child: Obx(
                                () => Text(
                                  "${controller.outlet.value.outletName}-${controller.outlet.value.location}",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.grey.shade600),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 5.0, right: 5.0, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Remarks: ",
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: TextField(
                                style: GoogleFonts.roboto(fontSize: 14),
                                maxLines: 3,
                                controller: _remarksController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  hintText: "Type Remarks Here",
                                  hintStyle: GoogleFonts.roboto(fontSize: 14),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade600)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 2, right: 2),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const ImageDialog();
                                },
                              ));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.blueAccent,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Show Planogram",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Obx(
                            () => Opacity(
                              opacity:
                                  _disableAssetScanningBtn.value ? 0.5 : 1.0,
                              child: InkWell(
                                onTap: _disableAssetScanningBtn.value
                                    ? null
                                    : () {
                                        Get.toNamed(EdsRoutes.assetVerification,
                                            arguments: [outletId]);
                                      },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.blueAccent,
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    _disableAssetScanningBtn.value
                                        ? "No Assets"
                                        : "Asset Verification",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 2, right: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => SizedBox(
                          height: 120,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.beforeImages.value.length,
                            itemBuilder: (context, index) {
                              return MerchandisingListItem(
                                merchandiseImage:
                                    controller.beforeImages.value[index],
                                deleteCallback: () {
                                  controller.removeMerchandiseImage(
                                      controller.beforeImages.value[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      CustomButton(
                        onTap: () => getImageFromCamera(true),
                        text: "Before Merchandising",
                        horizontalPadding: 80,
                        minWidth: 180,
                      ),
                      Obx(
                        () => SizedBox(
                          height: 120,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.afterImages.value.length,
                            itemBuilder: (context, index) {
                              return MerchandisingListItem(
                                merchandiseImage:
                                    controller.afterImages.value[index],
                                deleteCallback: () {
                                  controller.removeMerchandiseImage(
                                      controller.afterImages.value[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Obx(() => CustomButton(
                            onTap: () => getImageFromCamera(false),
                            text: "After Merchandising",
                            horizontalPadding: 80,
                            minWidth: 180,
                            enabled: controller.beforeImages.value.isNotEmpty,
                          )),
                    ],
                  ),
                ),
              ),
              Obx(
                () => CustomButton(
                  onTap: () => _onNextClick(),
                  text: "Next",
                  enabled: controller.beforeImages.value.isNotEmpty &&
                      controller.afterImages.value.isNotEmpty,
                  fontSize: 22,
                  horizontalPadding: 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Obx(
            () => controller.isLoading.value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void _setObservers() {
    debounce(controller.loadMerchandise(outletId), (merchandise) {
      _updateMerchandiseList(merchandise.merchandiseImages);
    }, time: const Duration(milliseconds: 200));

    debounce(controller.imagesLiveData,
        (merchandiseImages) => _updateMerchandiseList(merchandiseImages),
        time: const Duration(milliseconds: 200));

    debounce(controller.getAssets(outletId), (assets) {
      if (assets.isEmpty) {
        _disableAssetsScanningBtn(true);
        isAssets = false;
      } else {
        _disableAssetsScanningBtn(false);
        isAssets = true;
        int assetVerified = 0;

        for (Asset asset in assets) {
          if (asset.getVerified()) {
            assetVerified++;
          }

          if (assetVerified == assets.length) {
            controller.setAssetsScannedInLastMonth(true);
          }
        }
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.isSaved, (aBoolean) async {
      if (aBoolean && assetsVerified) {
        final taskList = await controller.getTasksByOutletId(outletId);
        if (taskList != null && taskList.isNotEmpty) {
          final result =
              await Get.toNamed(EdsRoutes.pendingTask, arguments: [outletId]);
          if (result != null) {
            Get.back(result: result);
          }
        } else {
          final result =
              await Get.toNamed(EdsRoutes.orderBooking, arguments: [outletId]);
          //send result back to the previous screen
          if (result != null) {
            Get.back(result: result);
          }
        }
      } else {
        Map<String, dynamic> extraParams = {
          Constants.WITHOUT_VERIFICATION: true,
          Constants.EXTRA_PARAM_NO_ORDER_FROM_BOOKING: true,
          Constants.EXTRA_PARAM_OUTLET_ID: outletId,
        };
        Get.back(result: extraParams);
      }
    }, time: const Duration(milliseconds: 200));
  }

  Future<void> getImageFromCamera(bool beforeMerchandising) async {
    PermissionStatus cameraPermission = await Permission.camera.status;

    if (cameraPermission == PermissionStatus.denied) {
      cameraPermission = await Permission.camera.request();

      if (cameraPermission == PermissionStatus.permanentlyDenied) {
        return Future.error(
            "Camera permissions are permanently denied, we cannot request permissions.");
      }
    }
    try {
      final ImagePicker picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setLoading(true);

        File? watermarkedImage = await _addWatermark(pickedFile.path);
        setLoading(false);
        if (beforeMerchandising) {
          controller.saveImages(
              watermarkedImage?.path, Constants.MERCHANDISE_BEFORE_IMAGE);
        } else {
          controller.saveImages(
              watermarkedImage?.path, Constants.MERCHANDISE_AFTER_IMAGE);
        }
      } else {
        setLoading(false);
        showToastMessage("No Image Captured!");
      }
    } catch (e) {
      setLoading(false);
      showToastMessage("Something went wrong.Please try again!");
    }
  }

  /*Future<File?> addWatermark(String imagePath) async {
    try {
      // Get the current date and time
      DateTime now = DateTime.now();
      String formattedDateTime =
          "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";

      // Read the original image
      File file = File(imagePath);
      List<int> imageBytes = file.readAsBytesSync();
      img.Image? originalImage =
          img.decodeImage(Uint8List.fromList(imageBytes));

      // Scale the image to adjust the font size
      double scaleFactor = calculateScaleFactor(
          originalImage); // Adjust the scale factor as needed
      img.Image resizedImage = img.copyResize(originalImage!,
          width: (originalImage.width * scaleFactor).round());

      // Add watermark text
      img.drawString(resizedImage, img.arial_48, 20, 20, formattedDateTime,
          color: img.getColor(255, 0, 0));

      // Create a new File for the watermarked image
      String outputImagePath = imagePath.replaceAll('.jpg',
          '_watermarked.png'); // Customize the output file name if needed
      File watermarkedFile = File(outputImagePath);

      // Save the watermarked image
      watermarkedFile.writeAsBytesSync(img.encodePng(resizedImage));
      // Return the File representing the watermarked image
      return watermarkedFile;
    } catch (e) {
      showToastMessage(e.toString());
    }
    return null;
  }*/

  Future<File?> _addWatermark(String imagePath) async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(
      _processImageInIsolate,
      [receivePort.sendPort, imagePath],
    );
    return await receivePort.first as File?;
  }

  static double calculateScaleFactor(img.Image? image) {
    if (image != null) {
      // Determine the desired width or height for resizing (you can adjust this as needed)
      double targetWidth = 700; // Adjust to your desired width

      // Calculate the scale factor based on the aspect ratio and the target width
      double scaleFactor = targetWidth / image.width;

      // Ensure that the scale factor is within a reasonable range
      scaleFactor = math.max(scaleFactor, 0.1); // Minimum scale factor
      scaleFactor = math.min(scaleFactor, 2.0); // Maximum scale factor

      return scaleFactor;
    }

    return 0.5;
  }

  void _onNextClick() {
    if (!controller.validateImageCount()) {
      return;
    }
    if (isAssets) {
      if (controller.getEnforceAssetScan() ||
          (controller.getEnforceAssetScan() &&
              controller.getAssetsScanned() &&
              controller.getAssetsVerifiedCount() > 0) ||
          controller.isTestUser()) {
        controller.outlet.value.isAssetsScennedInTheLastMonth = true;
        controller.updateOutlet(controller.outlet.value);
        String remarks = _remarksController.text.toString();
        int? statusId = controller.outlet.value.statusId;
        controller.insertMerchandiseIntoDB(outletId, remarks, statusId);
      } else {
        if (controller.getAssetsScanned() ||
            controller.getAssetsVerifiedCount() == 0) {
          _showAlertDialog();
        } else {
          showToastMessage("Please scan all assets");
        }
      }
    } else {
      String remarks = _remarksController.text.toString();
      int? statusId = controller.outlet.value.statusId;
      controller.insertMerchandiseIntoDB(outletId, remarks, statusId);
    }
  }

  static Future<void> _processImageInIsolate(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String imagePath = args[1];

    try {
      // Get the current date and time
      // Get the current date and time
      DateTime now = DateTime.now();
      String formattedDateTime =
          "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";

      // Read the original image
      File file = File(imagePath);
      List<int> imageBytes = file.readAsBytesSync();
      img.Image? originalImage =
          img.decodeImage(Uint8List.fromList(imageBytes));

      // Scale the image to adjust the font size
      double scaleFactor = calculateScaleFactor(
          originalImage); // Adjust the scale factor as needed
      img.Image resizedImage = img.copyResize(originalImage!,
          width: (originalImage.width * scaleFactor).round());

      // Add watermark text
      img.drawString(resizedImage, img.arial_48, 20, 20, formattedDateTime,
          color: img.getColor(255, 0, 0));

      // Create a new File for the watermarked image
      String outputImagePath = imagePath.replaceAll('.jpg',
          '_watermarked.png'); // Customize the output file name if needed
      File watermarkedFile = File(outputImagePath);

      // Save the watermarked image
      watermarkedFile.writeAsBytesSync(img.encodeJpg(resizedImage));
      // sendPort.send({'outputImagePath': outputImagePath});
      Isolate.exit(sendPort, watermarkedFile);
    } catch (e) {
      // sendPort.send({'error': e.toString()});
      Isolate.exit();
    }
  }

  void _updateMerchandiseList(List<MerchandiseImage>? merchandiseImages) {
    List<MerchandiseImage> merchandiseImagesBefore = [];
    List<MerchandiseImage> merchandiseImagesAfter = [];
    if (merchandiseImages != null) {
      for (MerchandiseImage image in merchandiseImages) {
        if (image.type == Constants.MERCHANDISE_BEFORE_IMAGE) {
          merchandiseImagesBefore.add(image);
        } else {
          merchandiseImagesAfter.add(image);
        }
      }
    }

    controller.populateMerchandise(true, merchandiseImagesBefore);
    controller.populateMerchandise(false, merchandiseImagesAfter);
  }

  void setLoading(bool value) {
    controller.setLoading(value);
  }

  void _disableAssetsScanningBtn(bool enable) {
    _disableAssetScanningBtn(enable);
    _disableAssetScanningBtn.refresh();
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
        Text("Info", style: GoogleFonts.roboto(color: Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Please scan at least one asset to proceed.",
                style: GoogleFonts.roboto(color: Colors.black87)),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                    _showConfirmationDialog();
                    },
                    child: Text("Back to PJP",
                        style:
                        GoogleFonts.roboto(color: Colors.black87))),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.toNamed(EdsRoutes.assetVerification,
                          arguments: [outletId]);
                    },
                    child: Text("Scan Again",
                        style:
                        GoogleFonts.roboto(color: Colors.black87))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation",
            style: GoogleFonts.roboto(
                color: Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Are you sure you want to Back to PJP",
                style: GoogleFonts.roboto(
                    color: Colors.black87)),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: GoogleFonts.roboto(
                            color: Colors.black87))),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      controller.outlet.value
                          .isAssetsScennedInTheLastMonth =
                      true;
                      controller.outlet.value.synced =
                      false;
                      controller.updateOutlet(
                          controller.outlet.value);
                      String remarks =
                      _remarksController.text
                          .toString();
                      int? statusId = controller
                          .outlet.value.statusId;
                      controller
                          .insertMerchandiseIntoDB(
                          outletId,
                          remarks,
                          statusId);

                      assetsVerified = false;
                    },
                    child: Text("Ok",
                        style: GoogleFonts.roboto(
                            color: Colors.black87))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
