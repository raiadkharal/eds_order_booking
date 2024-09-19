import 'package:get/get.dart';
import 'package:order_booking/db/entities/order_quantity/order_quantity.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/cash_memo/cash_memo_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';
import 'package:order_booking/utils/Constants.dart';

import '../../db/entities/order_detail/order_detail.dart';
import '../../model/order_detail_and_price_breakdown/order_detail_and_price_breakdown.dart';
import '../../model/product_stock_in_hand/product_stock_in_hand.dart';

class CashMemoViewModel extends GetxController {
  final CashMemoRepository _repository;
  final OutletDetailRepository _outletDetailRepository;
  final StatusRepository _statusRepository;

  RxString outletName = "".obs;
  RxList<OrderDetailAndPriceBreakdown> cartItemList = RxList();

  CashMemoViewModel(
      this._repository, this._outletDetailRepository, this._statusRepository);

  Future<void> updateProduct(int? outletId, bool? fromBackPress) async {
    OrderEntityModel? orderModel = await _repository.findOrder(outletId);

    if (orderModel?.orderDetailAndCPriceBreakdowns != null) {
      for (OrderDetailAndPriceBreakdown orderDetail
          in orderModel!.orderDetailAndCPriceBreakdowns!) {
        updateProductStockInHand(orderDetail.orderDetail, fromBackPress);
      }
    }
  }

  Future<void> updateProductStockInHand(
      OrderDetail orderDetail, bool? backPress) async {
    ProductStockInHand? productStockInHand =
        await getProductStockInHand(orderDetail.mProductId);

    if (productStockInHand == null) return;

    int remainingUnitStock = 0;
    int remainingCartonStock = 0;

    if (backPress ?? true) {
      //subtract stock from stockInHand when new return item added
      //convert total stock in unit and subtract from unit stock in hand
      remainingUnitStock = productStockInHand.unitStockInHand -
          (((orderDetail.mCartonQuantity ?? 0) * 60) +
              (orderDetail.mUnitQuantity ?? 0));
      remainingCartonStock = productStockInHand.unitStockInHand -
          (orderDetail.mCartonQuantity ?? 0);
    } else {
      //add stock in stockInHand when new return item removed
      //convert total stock in unit and subtract from unit stock in hand
      remainingUnitStock = productStockInHand.unitStockInHand +
          (((orderDetail.mCartonQuantity ?? 0) * 60) +
              (orderDetail.mUnitQuantity ?? 0));
      remainingCartonStock = productStockInHand.unitStockInHand +
          (orderDetail.mCartonQuantity ?? 0);
    }

    updateProductStock(
        orderDetail.mProductId, remainingUnitStock, remainingCartonStock);
  }

  void updateProductStock(
      int? productId, int unitStockInHand, int cartonStockInHand) {
    _repository.updateProductStock(
        productId, unitStockInHand, cartonStockInHand);
  }

  Future<ProductStockInHand?> getProductStockInHand(int? id) async {
    return await _repository.getProductStockInHand(id);
  }

  void loadOutlet(int? outletId) {
    if (outletId != null) {
      _outletDetailRepository.getOutletById(outletId).then(
        (outlet) {
          outletName("${outlet.outletName} - ${outlet.location}");
          outletName.refresh();
        },
      );
    }
  }

  Rx<OrderEntityModel> getOrder(int outletId) {
    Rx<OrderEntityModel> orderLiveData = OrderEntityModel().obs;

    _repository.findOrder(outletId).then(
      (orderModel) {
        double freeQty = 0.0;

        if (orderModel?.orderDetailAndCPriceBreakdowns != null) {
          for (OrderDetailAndPriceBreakdown orderWithDetails
              in orderModel!.orderDetailAndCPriceBreakdowns!) {
            int? unitFreeQty =
                orderWithDetails.orderDetail.unitFreeGoodQuantity;
            int? cartonFreeQty =
                orderWithDetails.orderDetail.cartonFreeGoodQuantity;

            if (orderWithDetails.orderDetail.cartonFreeQuantityTypeId ==
                    Constants.PRIMARY ||
                orderWithDetails.orderDetail.unitFreeQuantityTypeId ==
                    Constants.PRIMARY) {
              cartonFreeQty = 0;
              unitFreeQty = 0;

              if (orderWithDetails.orderDetail.cartonFreeGoods != null) {
                for (OrderDetail freeItem
                    in orderWithDetails.orderDetail.cartonFreeGoods!) {
                  if (freeItem.mCartonQuantity != null) {
                    // Added By Husnain
                    cartonFreeQty =
                        cartonFreeQty! + (freeItem.mCartonQuantity ?? 0);
                  } else if (freeItem.mUnitQuantity != null) {
                    unitFreeQty = unitFreeQty! + (freeItem.mUnitQuantity ?? 0);
                  }
                }
              }

              if (orderWithDetails.orderDetail.unitFreeGoods != null) {
                for (OrderDetail freeItem
                    in orderWithDetails.orderDetail.unitFreeGoods!) {
                  if (freeItem.mUnitQuantity != null) {
                    // Added By Husnain
                    unitFreeQty = unitFreeQty! + (freeItem.mUnitQuantity ?? 0);
                  } else if (freeItem.mCartonQuantity != null) {
                    cartonFreeQty =
                        cartonFreeQty! + (freeItem.mCartonQuantity ?? 0);
                  }
                }
              }
            }

            //                String freeQtyStr = Util.convertToDecimalQuantity(cartonFreeQty==null?0:cartonFreeQty,unitFreeQty==null?0:unitFreeQty);
            freeQty =
                freeQty + (unitFreeQty ?? 0); //Double.parseDouble(freeQtyStr);

            //freeGoods.addAll(orderWithDetails.getOrderDetail().getCartonFreeGoods());
            // freeGoods.addAll(orderWithDetails.getOrderDetail().getUnitFreeGoods());
            if (orderWithDetails.cartonPriceBreakDownList != null &&
                orderWithDetails.cartonPriceBreakDownList!.isNotEmpty) {
              orderWithDetails.orderDetail.cartonPriceBreakDown =
                  orderWithDetails.cartonPriceBreakDownList;
              orderWithDetails.orderDetail.unitPriceBreakDown =
                  orderWithDetails.unitPriceBreakDownList;
            } else {
              orderWithDetails.cartonPriceBreakDownList =
                  orderWithDetails.orderDetail.cartonPriceBreakDown;
              orderWithDetails.unitPriceBreakDownList =
                  orderWithDetails.orderDetail.unitPriceBreakDown;
            }
          }
        }
        orderModel?.freeAvailableQty = freeQty;
        // orderModel.setFreeGoods(freeGoods);
        return orderModel;
      },
    ).then(
      (orderModel) {
        orderLiveData(orderModel);
      },
    );

    return orderLiveData;
  }

  void updateCartItems(
      List<OrderDetailAndPriceBreakdown>? orderDetailAndCPriceBreakdowns) {
    cartItemList(orderDetailAndCPriceBreakdowns);
    cartItemList.refresh();
  }

  Future<OrderStatus?> findOrderStatus(int? outletId) {
    return _statusRepository.findOrderStatus(outletId ?? 0);
  }

  void updateStatus(OrderStatus? orderStatus) {
    _statusRepository.update(orderStatus);
  }

  void saveOrderAndAvailableStockData(List<OrderAndAvailableQuantity> orderAndAvailableQuantityList) {
  _repository.saveOrderAndAvailableStockData(orderAndAvailableQuantityList);
  }
}
