import 'package:order_booking/db/dao/order_dao.dart';
import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/model/product_stock_in_hand/product_stock_in_hand.dart';

class CashMemoRepository{

  final ProductDao _productDao;
  final OrderDao _orderDao;


  CashMemoRepository(this._productDao, this._orderDao);

  void updateProductStock(int? productId, int unitStockInHand, int cartonStockInHand) {
    _productDao.updateProductStock(productId,unitStockInHand,cartonStockInHand);
  }

  Future<ProductStockInHand?> getProductStockInHand(int? id) {
    return _productDao.getProductStockInHand(id);
  }

  Future<OrderEntityModel?> findOrder(int? outletId) {
    return _orderDao.getOrderWithItems(outletId);
  }


}