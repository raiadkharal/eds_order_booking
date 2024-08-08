import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/db/entities/carton_price_breakdown/carton_price_breakdown.dart';
import 'package:order_booking/db/entities/order/order.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/order_quantity/order_quantity.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/db/entities/product_group/product_group.dart';
import 'package:order_booking/db/entities/unit_price_breakdown/unit_price_breakdown.dart';
import 'package:order_booking/db/models/work_status/work_status.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/order_model/order_model.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/model/packageModel/package_model.dart';

import '../../db/dao/order_dao.dart';
import '../../db/dao/route_dao.dart';
import '../../utils/PreferenceUtil.dart';

class OrderBookingRepository {
  final ProductDao _productDao;
  final OrderDao _orderDao;
  final RouteDao _routeDao;
  final PreferenceUtil _preferenceUtil;

  OrderBookingRepository(this._productDao, this._orderDao, this._routeDao, this._preferenceUtil);

  Future<List<Package>> findAllPackages() async {
    return _productDao.getAllPackages();
  }

  Future<List<ProductGroup>> findAllGroups() async {
    return _productDao.getAllGroups();
  }

  Future<List<Product>> findAllProductsByPackage(int? packageId) async {
    return _productDao.findAllProductsByPkg(packageId);
  }

  Future<List<OrderDetail>> getOrderItems(int? id) async {
    return _productDao.findOrderItemsByOrderId(id);
  }

  List<PackageModel>? packageModel(
      List<Package>? packages, List<Product> productList) {
    if (packages == null) {
      return null;
    }
    List<PackageModel> packageModels = [];

    for (Package package in packages) {
      List<Product> products =
          _getProductsByPkgId(package.packageId, productList);
      if (products.isNotEmpty) {
        PackageModel model = PackageModel(
            packageId: package.packageId,
            packageName: package.packageName,
            products: products);
        packageModels.add(model);
      }
    }
    return packageModels;
  }

  List<Product> _getProductsByPkgId(int? packageId, List<Product> productList) {
    List<Product> filteredList = [];
    for (Product product in productList) {
      if (product.packageId == packageId) {
        filteredList.add(product);
      }
    }

    return filteredList;
  }

  Future<void> createOrder(OrderModel order) async {
    _orderDao.insertOrder(Order.fromJson(order.toJson()));
  }

  Future<void> deleteOrderItemsByPackage(int? id, int? packageId) async {
    _orderDao.deleteOrderItemsByPkg(id, packageId);
  }

  Future<OrderEntityModel?> findOrder(int? outletId) async{
    return _orderDao.getOrderWithItems(outletId);
  }

  Future<void> addOrderItems(List<OrderDetail>? orderDetails) async {
    _orderDao.insertOrderItems(orderDetails);
  }

  Future<List<Product>> getAllProducts() async{
    return await _productDao.getAllProducts();
  }

  Future<Outlet> findOutletById(int outletId)async=>_routeDao.getOutletById(outletId);

  Future<Order> findOrderById(int? mobileOrderId) {
   return _orderDao.findOrderById(mobileOrderId);
  }

  Future<void> updateOrder(Order? order) async{
    _orderDao.updateOrder(order);
  }

  WorkStatus getWorkSyncData()=>_preferenceUtil.getWorkSyncData();

  Future<void> deleteOrderItems(int? orderId) async{
    _orderDao.deleteOrderItems(orderId);
  }

  void addOrderUnitPriceBreakDown(List<UnitPriceBreakDown>? unitPriceBreakDown) {
    _orderDao.insertUnitPriceBreakDown(unitPriceBreakDown);
  }

  void addOrderCartonPriceBreakDown(List<CartonPriceBreakDown>? cartonPriceBreakDown) {
    _orderDao.insertCartonPriceBreakDown(cartonPriceBreakDown);
  }

  bool isShowMarketReturnButton()=> _preferenceUtil.getShowMarketReturnsButton();

  void deleteOrderUnitPriceBreakdown(int? orderDetailId) {
    _orderDao.deleteOrderUnitPriceBreakdown(orderDetailId);
  }

  void deleteOrderCartonPriceBreakdown(int? orderDetailId) {
    _orderDao.deleteOrderCartonPriceBreakdown(orderDetailId);
  }

  void saveOrderAndAvailableStockData(List<OrderAndAvailableQuantity> orderQuantityList) {
    _orderDao.insertOrderAndAvailableStockData(orderQuantityList);
  }

  void deleteOrderAndAvailableStockByOutlet(int? outletId) {
    _orderDao.deleteOrderAndAvailableStockByOutlet(outletId);
  }

  Future<List<OrderAndAvailableQuantity>> getOrderAndAvailableQuantityDataByOutlet(int? outletId) {
    return _orderDao.getOrderAndAvailableQuantityDataByOutlet(outletId);
  }

}
