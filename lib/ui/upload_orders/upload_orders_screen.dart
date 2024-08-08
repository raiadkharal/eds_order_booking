import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/ui/home/home_view_model.dart';
import 'package:order_booking/ui/upload_orders/upload_orders_view_model.dart';
import 'package:order_booking/utils/network_manager.dart';
import 'package:order_booking/utils/utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../components/button/cutom_button.dart';
import '../../components/progress_dialog/PregressDialog.dart';
import '../../utils/Colors.dart';
import '../../utils/util.dart';

class UploadOrdersScreen extends StatefulWidget {
  const UploadOrdersScreen({super.key});

  @override
  State<UploadOrdersScreen> createState() => _UploadOrdersScreenState();
}

class _UploadOrdersScreenState extends State<UploadOrdersScreen> {
  final UploadOrdersViewModel controller =
      Get.put(UploadOrdersViewModel(Get.find()));

  final HomeViewModel homeController = Get.find<HomeViewModel>();

  RxString tvRunningDay = "".obs;
  RxString tvPending = "".obs;
  RxString tvUploaded = "".obs;

  final RxBool _isBtnUploadEnabled = true.obs;

  @override
  void initState() {
    super.initState();

    init();
    setObservers();
    controller.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            title: Text(
              "Upload Orders",
              style: GoogleFonts.roboto(color: Colors.white),
            )),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order List",
                            style: GoogleFonts.roboto(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 26),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Obx(
                          () => Text(tvRunningDay.value,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: Obx(
                      () => MaterialButton(
                        onPressed: () =>
                            _isBtnUploadEnabled.value ? _onUploadClick() : null,
                        color: _isBtnUploadEnabled.value?secondaryColor:Colors.grey,
                        child: Text(
                          "UPLOAD",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      color: primaryColor,
                      height: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset("assets/images/ic_done.png")),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                tvUploaded.value,
                                style: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                                height: 20,
                                width: 20,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/ic_done.png"),
                                  color: Colors.red,
                                  colorBlendMode: BlendMode.color,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                tvPending.value,
                                style: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        itemCount: controller.getOrders().length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.getOrders()[index].outletName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        color: Colors.grey.shade600,
                                        fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/ic_done.png"),
                                      color: Colors.green,
                                      colorBlendMode: BlendMode.color,
                                    ))
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.grey,
                            height: 1,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? const SimpleProgressDialog()
                  : const SizedBox(),
            )
          ],
        ));
  }

  void init() {
    if (homeController.getWorkSyncData().syncDate != 0) {
      String date = Util.formatDate(
          Util.DATE_FORMAT_3, homeController.getWorkSyncData().syncDate);
      tvRunningDay("( $date )");
    }
  }

  void setObservers() {
    debounce(controller.getOrders(), (uploadStatusModels) {
      controller.getAllOrders();

      setUploadOrPendingCounts();
    }, time: const Duration(milliseconds: 200));
  }

  void setUploadOrPendingCounts() {
    tvPending(
        "Pending: ${controller.getPendingCount()}/${controller.getTotalCount()}");
    tvUploaded(
        "Uploaded: ${controller.getUploadedCount()}/${controller.getTotalCount()}");
  }

  void _onUploadClick() async {
    _isBtnUploadEnabled(false);
    final isOnline = await NetworkManager.getInstance().isConnectedToInternet();

    if (isOnline) {
      // progressCancelable=false;

      WakelockPlus.enable();

      homeController.handleMultipleSyncOrderSync().whenComplete(
        () {
          WakelockPlus.disable();
          _isBtnUploadEnabled(true);
        },
      );
    } else {
      _isBtnUploadEnabled(true);
      showToastMessage("No Internet Connection");
    }
  }
}
