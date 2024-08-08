import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:order_booking/db/entities/market_return_reason/market_return_reasons.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/ui/market_return/product_selection_dialog/product_selection_dialog.dart';
import 'package:order_booking/utils/Colors.dart';
import 'package:order_booking/utils/util.dart';
import 'package:order_booking/utils/utils.dart';

import '../../../utils/Constants.dart';
import '../../../utils/positive_number_text_input_formater.dart';
import '../market_return_repository.dart';
import '../market_return_view_model.dart';

class ReturnItemDialog extends StatefulWidget {
  final List<MarketReturnReason> marketReturnReasons;
  final List<MarketReturnDetail> returnList;
  final Product? product;
  final int? outletId;
  final double orderQty;
  final Function(MarketReturnDetail) onSaveClick;

  const ReturnItemDialog(
      {super.key,
      required this.marketReturnReasons,
      required this.product,
      required this.outletId,
      required this.orderQty,
      required this.returnList,
      required this.onSaveClick});

  @override
  State<ReturnItemDialog> createState() => _ReturnItemDialogState();
}

class _ReturnItemDialogState extends State<ReturnItemDialog> {
  final MarketReturnViewModel controller = Get.put(MarketReturnViewModel(
      MarketReturnRepository(Get.find(), Get.find(), Get.find()), Get.find()));

  final TextEditingController _returnQtyController = TextEditingController();
  TextEditingController _replaceQtyController = TextEditingController();

  Product _product = Product();

  late final MarketReturnDetail returnItem;
  Product? replaceProduct;
  RxString replaceWith = "".obs;
  RxBool replaceWithEnabled = false.obs;

  int replaceProductOrderQty = 0;
  Rx<MarketReturnReason?> selectedReason = Rx(null);
  final RxString _errorMessage = "".obs;

  @override
  void initState() {
    _product = widget.product ?? Product();
    returnItem = MarketReturnDetail(
        outletId: widget.outletId,
        productId: _product.id,
        unitDefinitionId: _product.unitDefinitionId,
        cartonDefinitionId: _product.unitDefinitionId,
        cartonSize: _product.cartonQuantity);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _errorMessage.value,
                      style: GoogleFonts.roboto(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Return Reason: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                      child: Theme(
                    data: Theme.of(context).copyWith(canvasColor: Colors.white),
                    child: DropdownButtonFormField(
                      onChanged: (value) {
                        selectedReason(value as MarketReturnReason);
                        selectedReason.refresh();

                        isReasonAlreadyAdded(selectedReason.value);

                        returnItem.marketReturnReasonId =
                            selectedReason.value?.id;
                        returnItem.returnedProductTypeId =
                            selectedReason.value?.returnedProductTypeId;

                        if (selectedReason.value != null &&
                            selectedReason.value!.id != 0) {
                          // _returnQtyController = TextEditingController();
                          enableDisableReplaceWith(
                              selectedReason.value, returnItem);
                        }
                      },
                      isDense: true,
                      value: widget.marketReturnReasons.isNotEmpty
                          ? widget.marketReturnReasons.first
                          : "",
                      isExpanded: true,
                      decoration: const InputDecoration(
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      items: widget.marketReturnReasons
                          .map(
                            (returnReason) => DropdownMenuItem(
                                value: returnReason,
                                child: Text(
                                  returnReason.marketReturnReason ?? "",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54),
                                )),
                          )
                          .toList(),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Return Qty: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Obx(
                            () => TextField(
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                PositiveNumberTextInputFormatter()
                              ],
                              enabled: selectedReason.value != null &&
                                  selectedReason.value!.id != 0,
                              onChanged: (value) =>
                                  validateReturnQuantity(value),
                              cursorColor: Colors.black54,
                              keyboardType: TextInputType.number,
                              controller: _returnQtyController,
                              style: GoogleFonts.roboto(
                                  color: Colors.black87, fontSize: 16),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                contentPadding: const EdgeInsets.all(5),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.grey)),
                                hintText: "Qty",
                                hintStyle: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: replaceWithEnabled.value
                        ? Colors.white
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Replace Product: ",
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.black54),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                        child: Theme(
                      data:
                          Theme.of(context).copyWith(canvasColor: Colors.white),
                      child: InkWell(
                        onTap: () => selectReplaceProduct(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Obx(
                              () => Text(
                                replaceWith.value,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                            const RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black87,
                                ))
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Replace Qty: ",
                      style: GoogleFonts.roboto(
                          fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Obx(
                            () => TextField(
                              maxLines: 1,
                              inputFormatters: [
                                PositiveNumberTextInputFormatter()
                              ],
                              onChanged: (s) => validateReplaceQuantity(s),
                              textAlign: TextAlign.center,
                              enabled: replaceWithEnabled.value,
                              cursorColor: Colors.black54,
                              keyboardType: TextInputType.number,
                              controller: _replaceQtyController,
                              style: GoogleFonts.roboto(
                                  color: Colors.black87, fontSize: 16),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                contentPadding: const EdgeInsets.all(5),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.grey)),
                                hintText: "Qty",
                                hintStyle: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.roboto(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                  TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (isValidData()) {
                          if (_errorMessage.value.isEmpty) {
                            Navigator.of(context).pop();
                            widget.onSaveClick(returnItem);
                          }
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.roboto(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isProductAlreadyAdded(Product? product) {
    if (product == null) return false;

    for (int i = 0; i < widget.returnList.length; i++) {
      MarketReturnDetail marketReturnDetail = widget.returnList[i];
      if (marketReturnDetail.marketReturnReasonId == selectedReason.value?.id &&
          marketReturnDetail.replacementProductId == product.id) {
        return true;
      }
    }
    return false;
  }

  void isReasonAlreadyAdded(MarketReturnReason? returnReason) {
    if (returnReason != null) {
      if (returnReason.returnedProductTypeId != 3) {
        for (int i = 0; i < widget.returnList.length; i++) {
          MarketReturnDetail marketReturnDetails = widget.returnList[i];
          if (marketReturnDetails.marketReturnReasonId ==
              selectedReason.value?.id) {
            setError("Return Reason Already added please select another one");
            return;
          } else {
            setError("");
          }
        }
      }
    }
  }

  void enableDisableReplaceWith(
      MarketReturnReason? returnReason, MarketReturnDetail returnItem) {
    if (returnReason == null) return;

    if (returnReason.returnedProductTypeId == 1) {
      replaceWith("NOT AVAILABLE");
      _returnQtyController.text = "NULL";
      returnItem.setReplacementQty(null, null);
      setReplaceWithEnabled(false);
    } else if (returnReason.returnedProductTypeId == 2) {
      replaceWith(_product.productName);
      returnItem.replaceWith = replaceWith.value;
      returnItem.setReplacementQty(
          returnItem.cartonQuantity, returnItem.unitQuantity);
      returnItem.replacementProductId = returnItem.productId;
      returnItem.replacementCartonSize = _product.cartonQuantity;
      returnItem.replacementUnitDefinitionId = returnItem.unitDefinitionId;
      returnItem.replacementCartonDefinitionId = returnItem.cartonDefinitionId;
      _replaceQtyController.text = Util.convertStockToDecimalQuantity(
              returnItem.cartonQuantity, returnItem.unitQuantity)
          .toString();
      setReplaceWithEnabled(false);
    } else if (returnReason.returnedProductTypeId == 3) {
      returnItem.replaceWith = null;
      replaceWith(returnItem.replaceWith ?? "SELECT PRODUCT");
      setReplaceWithEnabled(true);
      _replaceQtyController.text = "";
    }
  }

  void updateReplaceWithData(Product? product) {
    if (product != null) {
      returnItem.replacementProductId = product.id;
      returnItem.replacementCartonSize = product.cartonQuantity;
      returnItem.replacementCartonDefinitionId = product.cartonDefinitionId;
      returnItem.replacementUnitDefinitionId = product.unitDefinitionId;
      returnItem.replaceWith = product.productName;
    }
  }

  void setError(String message) {
    _errorMessage(message);
    _errorMessage.refresh();
  }

  void setReplaceWithEnabled(bool value) {
    replaceWithEnabled(value);
    replaceWithEnabled.refresh();
  }

  void validateReplaceQuantity(String s) {
    if (s.toString() == "" ||
        s.isEmpty ||
        (s.length == 1 && (s.toString() == "." || s.toString() == "-"))) {
      returnItem.setReplacementQty(null, null);
      return;
    }
    /* if (etReplaceQty.hasFocus()) {
                                tvError.setVisibility(View.GONE);
                              }*/

    double qty = -1;

    try {
      qty = double.parse(s.toString());
    } catch (e) {
      qty = -1;
    }

    if (qty >= 0) {
      final cu = Util.convertToLongQuantity(s.toString());

      if (selectedReason.value?.returnedProductTypeId == 3) {
        int? unitStock = replaceProduct?.unitStockInHand;
        int? enteredQty =
            Util.convertToUnits(cu?[0], replaceProduct?.cartonQuantity, cu?[1]);

        if (enteredQty > ((unitStock ?? 0) - replaceProductOrderQty)) {
          s = s.toString().substring(0, s.length - 1);
          _replaceQtyController.value = TextEditingValue(
            text: s,
            selection: TextSelection.fromPosition(
              TextPosition(offset: s.length),
            ),
          );
          setError("You cannot enter above maximum qty");
        } else if (enteredQty <= 0) {
          setError("Please enter correct replace quantity");
          returnItem.setReplacementQty(null, null);
        } else {
          setError("");
          returnItem.setReplacementQty(cu?[0], cu?[1]);
        }
      } else {
        setError("");
        returnItem.setReplacementQty(cu?[0], cu?[1]);
      }
    }
  }

  void selectReplaceProduct() {
    FocusScope.of(context).unfocus();
    if (replaceWithEnabled.value) {
      showDialog(
        context: context,
        builder: (context) => ProductSelectionDialog(
          onSaveClick: (Product? product) async {
            replaceProduct = product;
            replaceWith(product?.productName);
            replaceWith.refresh();

            if (product != null && widget.outletId != null) {
              OrderDetail? orderDetail =
                  await controller.getOrderDetail(product.id, widget.outletId);
              if (orderDetail != null) {
                replaceProductOrderQty = Util.convertToUnits(
                    orderDetail.mCartonQuantity,
                    orderDetail.cartonSize,
                    orderDetail.mUnitQuantity);
              }
            }

            if (isProductAlreadyAdded(product)) {
              setError("Product Already added with same reason code");
            } else {
              setError("");
              updateReplaceWithData(product);
              _replaceQtyController = TextEditingController();
            }
          },
        ),
      );
    }
  }

  void validateReturnQuantity(String s) {
    if (s.toString() == "" ||
        s.isEmpty ||
        (s.length == 1 && (s.toString() == "." || s.toString() == "-"))) {
      returnItem.setReturnQty(null, null);
      return;
    }
    // if (etReturnQty.hasFocus()) {
    //   tvError.setVisibility(View.GONE);
    // }

    double qty = -1;

    try {
      qty = double.parse(s.toString());
    } catch (e) {
      qty = -1;
    }

    if (qty >= 0) {
      final cu = Util.convertToLongQuantity(s.toString());

//                    if (selectedReason.getReturnedProductTypeId() < 3) {
      int? unitStock = _product.unitStockInHand;
      int enteredQty =
          Util.convertToUnits(cu?[0], _product.cartonQuantity, cu?[1]);

      if (enteredQty > ((unitStock ?? 0) - widget.orderQty) &&
          selectedReason.value?.returnedProductTypeId == 2) {
        s = s.toString().substring(0, s.length - 1);
        _returnQtyController.value = TextEditingValue(
          text: s,
          selection: TextSelection.fromPosition(
            TextPosition(offset: s.length),
          ),
        );
        setError("You cannot enter above maximum qty");
      } else if (enteredQty <= 0) {
        setError("Please enter correct return quantity");
        returnItem.setReturnQty(null, null);
      } else {
        setError("");
        returnItem.setReturnQty(cu?[0], cu?[1]);
        returnItem.setReplacementQty(cu?[0], cu?[1]);
        if (returnItem.returnedProductTypeId == 2) {
          _replaceQtyController.text = s.toString();
        }
      }
//                    } else {
//                        returnItem.setReturnQty(cu[0], cu[1]);
//                        if (returnItem.getReturnedProductTypeId() == 2) {
//                            etReplaceQty.setText(s.toString());
//                        }
//                    }
    }
  }

  bool isValidData() {
    isReasonAlreadyAdded(selectedReason.value);

    // reason not selected error
    if (returnItem.returnedProductTypeId == 0) {
      setError("Please select return reason");
      return false;

      // validations for "product swap" and "others" reason
    } else if (returnItem.returnedProductTypeId == 3) {
      if (returnItem.replacementProductId == null ||
          returnItem.replacementProductId == 0) {
        setError("Please select replace product");
        return false;
      } else if (returnItem.replacementUnitQuantity == null ||
          returnItem.replacementCartonQuantity == null) {
        setError("Please enter correct replace quantity");
        return false;
      } else if (returnItem.unitQuantity == null ||
          returnItem.cartonQuantity == null) {
        setError("Please enter correct return quantity");
        return false;
      }
    }
    // return quantity validation
    else if (returnItem.unitQuantity == null ||
        returnItem.cartonQuantity == null) {
      setError("Please enter correct return quantity");
      return false;
    }

    return true;
  }
}
