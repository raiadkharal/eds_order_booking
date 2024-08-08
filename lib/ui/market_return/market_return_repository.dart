import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/dao/market_returns_dao.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:order_booking/db/entities/market_returns/market_returns.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/model/product_stock_in_hand/product_stock_in_hand.dart';

import '../../db/dao/product_dao.dart';
import '../../db/dao/route_dao.dart';

class MarketReturnRepository{
  final MarketReturnsDao _marketReturnsDao;
  final ProductDao _productDao;
  final RouteDao _routeDao;

  MarketReturnRepository(this._marketReturnsDao, this._productDao, this._routeDao);

  void updateInvoiceIdByOutlet(int? outletId, int? invoiceId) {
    _marketReturnsDao.updateInvoiceIdByOutlet(outletId,invoiceId);
  }

  void addMarketReturn(MarketReturns marketReturns) {
    _marketReturnsDao.insertMarketReturn(marketReturns);
  }

  Future<List<MarketReturnDetail>?> getMarketReturnDetailsByOutletId(int? outletId) {
   return  _marketReturnsDao.getMarketReturnDetailsByOutletId(outletId);
  }

  Future<int?> getMarketReturnInvoiceIdByOutletId(int? outletId) {
    return _marketReturnsDao.getMarketReturnInvoiceByOutlet(outletId);
  }

  Future<Product?> findProductById(int? replacementProductId){
    return _productDao.findProductById(replacementProductId);
  }

 Future<LookUp?> getLookUpData() {
    return _routeDao.getLookUpData();
 }

  void deleteMarketReturnDetailByOutlet(int? outletId, int? productId) {
    _marketReturnsDao.deleteMarketReturnDetailByOutlet(outletId,productId);
  }

  void addMarketReturnDetails(RxList<MarketReturnDetail> returnList) {
    _marketReturnsDao.insertMarketReturnDetails(returnList);
  }

  Future<ProductStockInHand?> getProductStockInHand(int? productId) {
    return _productDao.getProductStockInHand(productId);
  }

  void updateProductStock(int? productId, int unitStockInHand, int cartonStockInHand) {
    _productDao.updateProductStock(productId, unitStockInHand, cartonStockInHand);
  }

  Future<List<MarketReturnDetail>> getAllMarketReturns(int? outletId, int? productId) {
    return _marketReturnsDao.getAllMarketReturns(outletId,productId);
  }

}