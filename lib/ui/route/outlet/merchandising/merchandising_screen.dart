import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_booking/db/models/merchandise_images/merchandise_image.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/route/outlet/merchandising/planogram/image_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

import '../../../../components/button/cutom_button.dart';
import '../../../../components/navigation_drawer/my_navigation_drawer.dart';
import '../../../../components/progress_dialog/PregressDialog.dart';
import '../../../../utils/Colors.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/utils.dart';
import 'merchandising_view_model.dart';
import 'merchandising_list_item.dart';

class MerchandisingScreen extends StatefulWidget {
  const MerchandisingScreen({super.key});

  @override
  State<MerchandisingScreen> createState() => _MerchandisingScreenState();
}

class _MerchandisingScreenState extends State<MerchandisingScreen> {
  final MerchandisingViewModel controller =
  Get.put(MerchandisingViewModel(Get.find()));

  bool isAssets = true,
      assetsVerified = true;

  // final MerchandisingViewModel controller =
  // Get.put(MerchandisingViewModel(Get.find()));

  late final int outletId;

  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      outletId = args[0];
    } else {
      outletId = 0;
    }
    setObservers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "EDS Survey",
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
                              flex: 5,
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
                              flex: 9,
                              child: Text(
                                "",
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey.shade600),
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
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(EdsRoutes.assetVerification);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.blueAccent,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "Asset Verification",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 16),
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
                            () =>
                            SizedBox(
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
                            () =>
                            SizedBox(
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
                      Obx(() =>
                          CustomButton(
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
                    () =>
                    CustomButton(
                      onTap: () => onNextClick(),
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
                () =>
            controller.isLoading.value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void setObservers() {
    ever(controller.loadMerchandise(outletId), (merchandise) {
      updateMerchandiseList(merchandise.merchandiseImages);
    });

    ever(
      controller.imagesLiveData,
          (merchandiseImages) => updateMerchandiseList(merchandiseImages),
    );

    ever(controller.isSaved, (aBoolean) async {
      if (aBoolean && assetsVerified) {
        showToastMessage("Saved");
        final taskList = await controller.getTasksByOutletId(outletId);

        if (taskList != null && taskList.isNotEmpty){
          Get.toNamed(EdsRoutes.pendingTask);
        }else{
          Get.toNamed(EdsRoutes.orderBooking);
        }
      }
    });
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

        File? watermarkedImage = await addWatermark(pickedFile.path);
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

  // Future<File?> addWatermark(String imagePath) async {
  //   try {
  //     // Get the current date and time
  //     DateTime now = DateTime.now();
  //     String formattedDateTime =
  //         "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";
  //
  //     // Read the original image
  //     File file = File(imagePath);
  //     List<int> imageBytes = file.readAsBytesSync();
  //     img.Image? originalImage =
  //         img.decodeImage(Uint8List.fromList(imageBytes));
  //
  //     // Scale the image to adjust the font size
  //     double scaleFactor = calculateScaleFactor(
  //         originalImage); // Adjust the scale factor as needed
  //     img.Image resizedImage = img.copyResize(originalImage!,
  //         width: (originalImage.width * scaleFactor).round());
  //
  //     // Add watermark text
  //     img.drawString(resizedImage, img.arial_48, 20, 20, formattedDateTime,
  //         color: img.getColor(255, 0, 0));
  //
  //     // Create a new File for the watermarked image
  //     String outputImagePath = imagePath.replaceAll('.jpg',
  //         '_watermarked.png'); // Customize the output file name if needed
  //     File watermarkedFile = File(outputImagePath);
  //
  //     // Save the watermarked image
  //     watermarkedFile.writeAsBytesSync(img.encodePng(resizedImage));
  //     // Return the File representing the watermarked image
  //     return watermarkedFile;
  //   } catch (e) {
  //     showToastMessage(e.toString());
  //   }
  //   return null;
  // }

  Future<File?> addWatermark(String imagePath) async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(
      processImageInIsolate,
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

  void onNextClick() {
    if (!controller.validateImageCount()) {
      return;
    }
    controller.insertMerchandiseIntoDB(outletId);
  }

  static Future<void> processImageInIsolate(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String imagePath = args[1];

    try {
      // Get the current date and time
      // Get the current date and time
      DateTime now = DateTime.now();
      String formattedDateTime =
          "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now
          .second}";

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

  void updateMerchandiseList(List<MerchandiseImage>? merchandiseImages) {
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
}
