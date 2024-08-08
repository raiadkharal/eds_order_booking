import 'dart:convert';

import 'package:get/get.dart';
import 'package:order_booking/data_source/remote/response/api_response.dart';
import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/entities/merchandise/merchandise.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/db/entities/route/route.dart';
import 'package:order_booking/db/models/configuration/configurations.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/model/master_model/master_model.dart';
import 'package:order_booking/model/package_product_response_model/package_product_response_model.dart';
import 'package:order_booking/utils/enums.dart';
import 'package:order_booking/utils/utils.dart';

import '../../../../data_source/remote/api_service.dart';
import '../../../../db/dao/merchandise_dao.dart';
import '../../../../utils/PreferenceUtil.dart';

class OutletDetailRepository {
  final RxBool _isLoading = false.obs;
  final RouteDao _routeDao;
  final PreferenceUtil _preferenceUtil;
  final MerchandiseDao _merchandiseDao;
  final ProductDao _productDao;
  final ApiService _apiService;

  OutletDetailRepository(this._routeDao, this._preferenceUtil,
      this._merchandiseDao, this._apiService, this._productDao);

  Future<Outlet> getOutletById(int outletId) {
    return _routeDao.getOutletById(outletId);
  }

  RxBool isLoading() => _isLoading;

  void setLoading(bool value) {
    _isLoading(value);
    _isLoading.refresh();
  }

  Future<List<Promotion>> getPromotionByOutletId(int outletId) {
    return _routeDao.getPromotionByOutletId(outletId);
  }

  ConfigurationModel getConfiguration() {
    return _preferenceUtil.getConfig();
  }

  bool isTestUser() => _preferenceUtil.isTestUser();

  int? getStartedDate() => _preferenceUtil.getWorkSyncData().syncDate;

  String getUserName() => _preferenceUtil.getUsername();

  int? getRequestCounter() => _preferenceUtil.getRequestCounter();

  Future<Merchandise?> findMerchandiseByOutletId(int? outletId) {
    return _merchandiseDao.findMerchandiseByOutletId(outletId);
  }

  Future<void> loadProductsFromServer() async {
    setLoading(true);
    final accessToken = _preferenceUtil.getToken();

    final response = await _apiService.loadTodayPackageProduct(accessToken);

    if (response.status == RequestStatus.SUCCESS) {
      PackageProductResponseModel responseModel =
          PackageProductResponseModel.fromJson(jsonDecode(response.data));

      _handleResponse(responseModel);
    } else {
      setLoading(false);
      showToastMessage(response.message.toString());
    }
  }

  Future<void> _handleResponse(PackageProductResponseModel response) async{
    if(bool.parse(response.success??"true")){
      _productDao.deleteAllProducts();
      _productDao.deleteAllProductGroups();
      _productDao.insertProducts(response.productList);
      _productDao.insertProductGroups(response.productGroups);
    }else{
      showToastMessage(response.errorMessage??"Unable to Load Stock");
    }
    setLoading(false);
  }

  Future<List<MRoute>> getRoutes() {
    return _routeDao.findAllRoutes();
  }
}
