import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';

import '../../../../db/models/outlet_order_status/outlet_order_status.dart';

class OutletListRepository{
  final RouteDao _routeDao;
  RxBool _loading =false.obs;

  OutletListRepository(this._routeDao);


  Future<List<Outlet>>  getPendingOutlets(){
    return _routeDao.getPendingOutlets();
  }

  Future<List<Outlet>> getVisitedOutlets() {
    return _routeDao.getVisitedOutlets();
  }

  Future<List<Outlet>> getProductiveOutlets() {
    return _routeDao.getProductiveOutlets();
  }

  Future<List<Outlet>> getUnPlannedOutlets(int routeId) {
    return _routeDao.getUnplannedOutlets(routeId);
  }

  Stream<List<Outlet>> getOutletStream(){
    return _routeDao.getOutletStream();
  }

  void setLoading(bool value){
    _loading(value);
    _loading.refresh();
  }

  RxBool getLoading()=>_loading;
}