import 'package:get/get.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/db/models/configuration/configurations.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';

import '../../../../utils/PreferenceUtil.dart';

class OutletDetailRepository {
  final RxBool _isLoading = false.obs;
  final RouteDao _routeDao;
  final PreferenceUtil _preferenceUtil;


  OutletDetailRepository(this._routeDao, this._preferenceUtil);


  Future<Outlet> getOutletById(int outletId) {
    return _routeDao.getOutletById(outletId);
  }


  RxBool isLoading()=>_isLoading;

  void setLoading(bool value){
    _isLoading(value);
    _isLoading.refresh();
  }

  Future<List<Promotion>> getPromotionByOutletId(int outletId) {
  return _routeDao.getPromotionByOutletId(outletId);
  }

  ConfigurationModel getConfiguration(){
    return _preferenceUtil.getConfig();
  }

  bool isTestUser() => _preferenceUtil.isTestUser();
}
