import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:order_booking/db/entities/market_return_reason/market_return_reasons.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/ui/market_return/market_return_repository.dart';
import 'package:order_booking/ui/market_return/market_return_view_model.dart';
import 'package:order_booking/utils/util.dart';

class MarketReturnListItem extends StatelessWidget {

  final MarketReturnDetail returnDetail;
  final List<MarketReturnReason> marketReturnReasons;
  final Function(MarketReturnDetail) onRemoveClick;
  const MarketReturnListItem({super.key, required this.returnDetail, required this.marketReturnReasons, required this.onRemoveClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(

        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed:() {
                  onRemoveClick(returnDetail);
                }, icon: const Icon(
                  Icons.close,
                  size: 20,
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Return Reason: ",
                      style:
                          GoogleFonts.roboto(fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      getReturnReasonById(returnDetail.marketReturnReasonId),
                      style: GoogleFonts.roboto(fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)),
                            child: Text(
                              Util.convertStockToDecimalQuantity(returnDetail.cartonQuantity, returnDetail.unitQuantity),
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: Colors.black54),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
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
                    child: Text(
                      getReplacementProductName(returnDetail)??"NOT AVAILABLE",
                      style: GoogleFonts.roboto(fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)),
                            child: Text(
                              Util.convertStockToDecimalQuantity(returnDetail.replacementCartonQuantity, returnDetail.replacementUnitQuantity),
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: Colors.black54),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String? getReplacementProductName(MarketReturnDetail returnDetail) {

    if(returnDetail.returnedProductTypeId==1){
      return null;
    }

    if(returnDetail.replaceWith==null&&returnDetail.replacementProductId!=0){
      // MarketReturnViewModel viewModel = MarketReturnViewModel(MarketReturnRepository(Get.find(),Get.find()));

      // Product? product = await viewModel.findProductById(returnDetail.replacementProductId);
      //
      // if(product!=null){
      //   return product.productName;
      // }
    }else{
      return returnDetail.replaceWith;
    }
    return null;
  }

  String getReturnReasonById(int? id) {
    for (int i = 0; i < marketReturnReasons.length; i++) {
      MarketReturnReason returnReason = marketReturnReasons[i];
      if (returnReason.id == id) {
        return returnReason.marketReturnReason??"";
      }
    }
    return "";
  }
}
