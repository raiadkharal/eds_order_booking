import 'package:get/get.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/model/product_stock_in_hand/product_stock_in_hand.dart';
import 'package:order_booking/ui/market_return/market_return_repository.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';

import '../../db/entities/market_return_detail/market_return_detail.dart';
import '../../db/entities/market_return_reason/market_return_reasons.dart';
import '../../model/order_detail_and_price_breakdown/order_detail_and_price_breakdown.dart';

class MarketReturnViewModel extends GetxController {
  final MarketReturnRepository _repository;
  final OrderBookingRepository _orderBookingRepository;
  LookUp? _lookUp;
  final RxList<MarketReturnDetail> returnList = RxList<MarketReturnDetail>();
  List<MarketReturnReason> marketReturnReasons = [];

  Rx<Product> product = Product().obs;

  MarketReturnViewModel(this._repository, this._orderBookingRepository);

  void loadProduct(int? replacementProductId) {
    _repository.findProductById(replacementProductId).then((value) {
      product(value??Product());
    },);
  }

  @override
  void onReady() async {
    _lookUp = await _repository.getLookUpData();
    initializedMarketReturnReasonsList();
    super.onReady();
  }

  LookUp? getLookUpData() => _lookUp;

  void initializedMarketReturnReasonsList() {
    //initialize market return reasons
    marketReturnReasons = _lookUp?.marketReturnReasons ?? [];
    marketReturnReasons[0] = MarketReturnReason(
        id: 0, marketReturnReason: "Select Reason", returnedProductTypeId: 0);
  }

  void addReturn(MarketReturnDetail returnItem) {
    returnList.add(returnItem);
    returnList.refresh();
  }

  void removeReturnItem(int returnId) {
    returnList.removeAt(returnId);
    returnList.refresh();
  }

  Future<OrderDetail?> getOrderDetail(int? productId, int? outletId) async {
    OrderEntityModel? orderModel =
        await _orderBookingRepository.findOrder(outletId);
    if (orderModel != null &&
        orderModel.orderDetailAndCPriceBreakdowns != null) {
      for (OrderDetailAndPriceBreakdown orderDetail
          in orderModel.orderDetailAndCPriceBreakdowns!) {
        if (orderDetail.orderDetail.mProductId== productId) {
          return orderDetail.orderDetail;
        }
      }
    }

    return null;
  }

  void deleteMarketReturnDetailByOutlet(int? outletId, int? productId) {
    _repository.deleteMarketReturnDetailByOutlet(outletId, productId);
  }

  void saveMarketReturns() {
    _repository.addMarketReturnDetails(returnList);
  }

  Future<ProductStockInHand?> getProductStockInHand(int? productId) {
    return _repository.getProductStockInHand(productId);
  }

  void updateProductStock(int? productId, int unitStockInHand, int cartonStockInHand) {
    _repository.updateProductStock(productId,unitStockInHand,cartonStockInHand);
  }

  void loadMarketReturns(int? outletId, int? productId) {
    _repository.getAllMarketReturns(outletId,productId).then((value) {
      returnList(value);
      returnList.refresh();
    },);
  }

  Future<void> updateProduct(int? productId) async{
    if(productId!=null){
      _repository.findProductById(productId).then((value) {
        product(value);
      },);
    }
  }
}
