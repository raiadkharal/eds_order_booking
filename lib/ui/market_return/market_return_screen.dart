import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/ui/market_return/market_return_list_item.dart';
import 'package:order_booking/ui/market_return/market_return_repository.dart';
import 'package:order_booking/ui/market_return/market_return_view_model.dart';
import 'package:order_booking/ui/market_return/return_item_dialog/return_item_dialog.dart';
import 'package:order_booking/utils/utils.dart';

import '../../db/entities/market_return_reason/market_return_reasons.dart';
import '../../model/product_stock_in_hand/product_stock_in_hand.dart';
import '../../utils/Colors.dart';

class MarketReturnScreen extends StatefulWidget {
  const MarketReturnScreen({super.key});

  @override
  State<MarketReturnScreen> createState() => _MarketReturnScreenState();
}

class _MarketReturnScreenState extends State<MarketReturnScreen> {
  final MarketReturnViewModel controller = Get.put(MarketReturnViewModel(
      MarketReturnRepository(Get.find(), Get.find(), Get.find()), Get.find()));

  int? _productId;
  int? _outletId;
  double? _orderQty;

  @override
  void initState() {
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      _productId = args[0];
      _outletId = args[1];
      _orderQty = (args[2] == null || args[2]
          .toString()
          .isEmpty)
          ? 0.0
          : double.parse(args[2].toString());
    }
    if (_productId != null) {
     controller.loadProduct(_productId);
    }

    controller.loadMarketReturns(_outletId,_productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          actions: [
            IconButton(
                onPressed: () => _saveData(), icon: const Icon(Icons.check))
          ],
          title: Text(
            "MARKET RETURNS",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 3,
            color: Colors.white,
            shadowColor: primaryColor,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "PRODUCT:",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child:Obx(() =>  Text(controller.product.value.productName ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500)),),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // controller.addReturn(MarketReturnDetail());
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) =>
                                ReturnItemDialog(
                                  marketReturnReasons:
                                  controller.marketReturnReasons,
                                  product: controller.product.value,
                                  outletId: _outletId ?? 0,
                                  orderQty: _orderQty ?? 0,
                                  returnList: controller.returnList,
                                  onSaveClick:
                                      (MarketReturnDetail returnItem) async {
                                    controller.addReturn(returnItem);

                                    await _updateProductStockInHand(
                                        returnItem, true);

                                    await controller
                                        .updateProduct(_productId);
                                  },
                                ),
                          );
                        },
                        icon: const Icon(
                          Icons.add_box,
                          size: 40,
                          color: secondaryColor,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () =>
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return MarketReturnListItem(
                          returnDetail: controller.returnList[index],
                          marketReturnReasons: controller.marketReturnReasons,
                          onRemoveClick: (returnDetail) async {
                            controller.removeReturnItem(index);
                            await _updateProductStockInHand(
                                returnDetail, false);

                            await controller
                                .updateProduct(_productId);
                          },
                        );
                      },
                      itemCount: controller.returnList.length),
            ),
          )
        ],
      ),
    );
  }

  //update product stock in hand in  product table
  Future<void> _updateProductStockInHand(MarketReturnDetail marketReturnDetails,
      bool isAddReturn) async {
    // if marketReturnProductTypeId is equal to 1, do nothing
    if (marketReturnDetails.returnedProductTypeId == 1) {
      return;
    }

    ProductStockInHand? productStockInHand = await controller
        .getProductStockInHand(marketReturnDetails.replacementProductId);

    int remainingUnitStock = 0;
    int remainingCartonStock = 0;

    if (isAddReturn && productStockInHand != null) {
      // subtract stock from stockInHand when new return item added
      // convert total stock in unit and subtract from unit stock in hand
      remainingUnitStock = productStockInHand.unitStockInHand -
          (((marketReturnDetails.replacementCartonQuantity ?? 0) * 60) +
              (marketReturnDetails.replacementUnitQuantity ?? 0));
      remainingCartonStock = productStockInHand.cartonStockInHand -
          (marketReturnDetails.replacementCartonQuantity ?? 0);
    } else if (productStockInHand != null) {
      // add stock in stockInHand when new return item removed
      // convert total stock in unit and subtract from unit stock in hand
      remainingUnitStock = productStockInHand.unitStockInHand +
          (((marketReturnDetails.replacementCartonQuantity ?? 0) * 60) +
              (marketReturnDetails.replacementUnitQuantity ?? 0));
      remainingCartonStock = productStockInHand.cartonStockInHand +
          (marketReturnDetails.replacementCartonQuantity ?? 0);
    }

    controller.updateProductStock(marketReturnDetails.replacementProductId,
        remainingUnitStock, remainingCartonStock);
  }

  void _saveData() {
    controller.deleteMarketReturnDetailByOutlet(_outletId,_productId);
    controller.saveMarketReturns();
    // showToastMessage("Data Saved Successfully");
    Navigator.of(context).pop();
  }
}
