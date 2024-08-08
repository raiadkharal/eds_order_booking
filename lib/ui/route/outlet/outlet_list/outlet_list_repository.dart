import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:order_booking/db/dao/order_dao.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/entities/order/order.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';

import '../../../../db/models/outlet_order_status/outlet_order_status.dart';

class OutletListRepository{
  final RouteDao _routeDao;
  final OrderDao _orderDao;
  final RxBool _loading =false.obs;

  OutletListRepository(this._routeDao, this._orderDao);


  Future<List<OutletOrderStatus>>  getPendingOutlets(){
    return _routeDao.getPendingOutlets();
  }

  Future<List<OutletOrderStatus>> getVisitedOutlets() {
    return _routeDao.getVisitedOutlets();
  }

  Future<List<OutletOrderStatus>> getProductiveOutlets() {
    return _routeDao.getProductiveOutlets();
  }

  Future<List<OutletOrderStatus>> getUnPlannedOutlets(int routeId) {
    return _routeDao.getUnplannedOutlets(routeId);
  }

  Stream<List<OutletOrderStatus>> getOutletStream(){
    return _routeDao.getOutletStream();
  }

  void setLoading(bool value){
    _loading(value);
    _loading.refresh();
  }

  RxBool getLoading()=>_loading;

  Future<int> getPjpCount() {
    return _routeDao.getPjpCount();
  }

  Future<int> getCompletedCount() {
    return _routeDao.getCompletedCount();
  }

  Future<int> getProductiveCount() {
    return _routeDao.getProductiveCount();
  }

  Future<int> getPendingCount() {
    return _routeDao.getPendingCount();
  }

  Future<List<OrderEntityModel>> getOrders() {
    return _orderDao.findAllOrders();
  }
}