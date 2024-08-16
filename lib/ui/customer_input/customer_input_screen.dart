import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:order_booking/components/button/cutom_button.dart';
import 'package:order_booking/components/progress_dialog/PregressDialog.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/ui/customer_input/customer_input_repository.dart';
import 'package:order_booking/ui/customer_input/customer_input_view_model.dart';
import 'package:order_booking/ui/home/home_view_model.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:order_booking/utils/network_manager.dart';
import 'package:order_booking/utils/util.dart';
import 'package:signature/signature.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../route.dart';
import '../../utils/utils.dart';

class CustomerInputScreen extends StatefulWidget {
  const CustomerInputScreen({super.key});

  @override
  State<CustomerInputScreen> createState() => _CustomerInputScreenState();
}

class _CustomerInputScreenState extends State<CustomerInputScreen> {
  final CustomerInputViewModel controller = Get.put(CustomerInputViewModel(
      CustomerInputRepository(Get.find(), Get.find(), Get.find()),
      Get.find(),
      Get.find(),
      Get.find()));

  final HomeViewModel _homeController = Get.find<HomeViewModel>();
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2, // Adjust the stroke width as needed
    penColor: Colors.black, // Adjust the pen color as needed
  );

  int? _outletId;
  int? _statusId;
  final RxString _tvOutletName = "".obs;
  final RxString _tvOrderAmount = "0.0".obs;
  final RxBool _isBtnNextEnabled = true.obs;

  final RxBool _hideCustomerInfo = false.obs;
  int _deliveryDateMilis = 0;

  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _strnController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      _outletId = args[0];
      controller.outletId = _outletId;
    }

    _setObservers();
    controller.findOrder(_outletId);

    if (controller.getDeliveryDate() != -1) {
      _deliveryDateMilis = controller.getDeliveryDate();
      _deliveryDateController.text =
          Util.formatDate("dd/MM/yyyy", controller.getDeliveryDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text("Customer Input"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top +
                      AppBar().preferredSize.height),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
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
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Obx(
                                          () => Text(
                                            _tvOutletName.value,
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Order Amount: ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Obx(
                                          () => Text(
                                            _tvOrderAmount.value,
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => _hideCustomerInfo.value
                                      ? const SizedBox()
                                      : Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "Customer CNIC: ",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 9,
                                                    child: TextField(
                                                      controller:
                                                          _cnicController,
                                                      maxLength: 13,
                                                      maxLines: 1,
                                                      buildCounter: (context,
                                                              {required currentLength,
                                                              required isFocused,
                                                              required maxLength}) =>
                                                          null,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        hintText:
                                                            "13 digits CNIC",
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                                fontSize: 14),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade600)),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "Customer STRN: ",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 9,
                                                    child: TextField(
                                                      maxLines: 1,
                                                      controller:
                                                          _strnController,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        hintText:
                                                            "Sales tax registration number",
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                                fontSize: 14),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade600)),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      "Mobile No. for Order: ",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 9,
                                                    child: TextField(
                                                      controller:
                                                          _mobileNumberController,
                                                      maxLines: 1,
                                                      maxLength: 11,
                                                      buildCounter: (context,
                                                              {required currentLength,
                                                              required isFocused,
                                                              required maxLength}) =>
                                                          null,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14),
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        hintText: "03XXXXXXXXX",
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                                fontSize: 14),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade600)),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          "Delivery Date: ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: InkWell(
                                          onTap: () async {
                                            final selectedDate =
                                                await _selectDeliveryDate();
                                            if (selectedDate != null) {
                                              _deliveryDateController.text =
                                                  selectedDate ?? "";
                                            }
                                            // showToastMessage(selectedDate ?? "");
                                          },
                                          child: TextField(
                                            controller: _deliveryDateController,
                                            readOnly: true,
                                            style: GoogleFonts.roboto(
                                                color: Colors.black87,
                                                fontSize: 14),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              enabled: false,
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              hintText: "1/01/2024",
                                              hintStyle: GoogleFonts.roboto(
                                                  fontSize: 14),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey.shade600)),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .grey.shade600)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      left: 5.0,
                                      right: 5.0,
                                      bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Remarks: ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: TextField(
                                          controller: _remarksController,
                                          style:
                                              GoogleFonts.roboto(fontSize: 14),
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                            hintText: "Type Remarks Here",
                                            hintStyle: GoogleFonts.roboto(
                                                fontSize: 14),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade600)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade600)),
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
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 5.0, right: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Customer Signature",
                                        style: GoogleFonts.roboto(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16),
                                      ),
                                      MaterialButton(
                                        color: Colors.grey,
                                        child: Text(
                                          "Clear Signature",
                                          style: GoogleFonts.roboto(
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _signatureController.clear();
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade200)),
                                    child: Signature(
                                      height: 150,
                                      controller: _signatureController,
                                      backgroundColor: Colors
                                          .white, // Adjust the background color as needed
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => CustomButton(
                          enabled: _isBtnNextEnabled.value,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _onNextClick();
                          },
                          text: "Next"),
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => controller.getIsSaving().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  Future<String?> _selectDeliveryDate() async {
    try {
      //show date picker dialog to user
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          barrierDismissible: false,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 0)),
          lastDate: DateTime(2101));

      // Convert selectedDate to String using intl package
      if (pickedDate != null) {
        return DateFormat('MM/dd/yyyy').format(pickedDate);
      }
    } catch (e) {
      showToastMessage("Something went wrong. Please try again later");
    }
    return null;
  }

  void _onOutletLoaded(Outlet? outlet) {
    if (outlet != null) {
      _statusId = outlet.statusId;
      _tvOutletName("${outlet.outletName} - ${outlet.location}");

      if (controller.getHideCustomerInfo() != null) {
        if (!controller.getHideCustomerInfo()!) {
          _mobileNumberController.text = outlet.mobileNumber ?? "";
          _cnicController.text = outlet.cnic ?? "";
          _strnController.text = outlet.strn ?? "";
        } else {
          _hideCustomerInfo(true);
        }
      }
    }
  }

  void _onOrderLoaded(OrderEntityModel? orderModel) {
    _tvOrderAmount(Util.formatCurrency(orderModel?.order?.payable, 2));
  }

  void _onNextClick() {
    if (_signatureController.isEmpty) {
      showToastMessage("Please take customer signature");
      return;
    }

    if (_deliveryDateController.text.isEmpty) {
      showToastMessage("Please select delivery date");
      return;
    }

    //disable next button
    _isBtnNextEnabled(false);

    //ask user to confirm his action
    _showConfirmationDialog(
      () async {
        Navigator.of(context).pop();
        //user confirmed his action
        String mobileNumber = _mobileNumberController.text;
        String remarks = _remarksController.text;
        String cnic = _cnicController.text;
        String strn = _strnController.text;

        final signature = await _signatureController.toPngBytes();
        String base64Sign="";
        if (signature != null) {
          base64Sign = base64Encode(signature); //compress signature and convert into base64
        }

        //disable next button
        _isBtnNextEnabled(false);

        //save Order
        controller.saveOrder(mobileNumber, remarks, cnic, strn, base64Sign,
            _deliveryDateMilis, _statusId);
      },
    );
  }

  void _showConfirmationDialog(Function() onConfirmation) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: const EdgeInsets.all(20),
        title: const Text("Confirmation"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Are you sure you want to Order?"),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _isBtnNextEnabled(true);
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: onConfirmation, child: const Text("OK")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setObservers() {
    debounce(controller.loadOutlet(_outletId), (outlet) {
      _onOutletLoaded(outlet);
    }, time: const Duration(milliseconds: 200));

    debounce(controller.order(), (order) {
      _onOrderLoaded(order);
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getSingleOrderUpdate(), (outletId) async {
      bool isOnline =
          await NetworkManager.getInstance().isConnectedToInternet();
      if (isOnline) {
        if (outletId != null) {
          //this will keep the screen ON
          WakelockPlus.enabled;

          String? msg = await _homeController.uploadSingleOrder(outletId);

          if (msg != null && msg.isNotEmpty) {
            // Show a toast message
            WidgetsBinding.instance.addPostFrameCallback((_) {

              showToastMessage(msg);

             /* ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg)),
              );*/

            });
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            //Clear screen on flag
            WakelockPlus.disable();
            controller.setOrderSaved(true);

            //pop stack until outlet list screen
            Get.until((route) => Get.currentRoute == EdsRoutes.outletList);
          });



        }
      } else {
        showToastMessage("No Internet Connection");
        controller.setIsSaving(false);
        controller.setOrderSaved(false);

        //pop stack until outlet list screen
        Get.until((route) => Get.currentRoute == EdsRoutes.outletList);
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getStartUploadService(), (outletId) {},
        time: const Duration(milliseconds: 200));

    debounce(controller.getMessage(), (msg) {
      showToastMessage(msg);
    }, time: const Duration(milliseconds: 200));

    debounce(controller.orderSaved(), (aBoolean) {
      if (aBoolean) {
        //pop stack until outlet list screen
        Get.until((route) => Get.currentRoute == EdsRoutes.outletList);
      } else {
        _isBtnNextEnabled(true);
      }
    }, time: const Duration(milliseconds: 200));
  }
}
