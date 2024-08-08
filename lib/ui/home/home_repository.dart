import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_booking/data_source/remote/api_service.dart';
import 'package:order_booking/db/dao/customer_dao.dart';
import 'package:order_booking/db/dao/market_returns_dao.dart';
import 'package:order_booking/db/dao/merchandise_dao.dart';
import 'package:order_booking/db/dao/order_dao.dart';
import 'package:order_booking/db/dao/pricing_dao.dart';
import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/dao/task_dao.dart';
import 'package:order_booking/db/entities/available_stock/available_stock.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/market_return_reason/market_return_reasons.dart';
import 'package:order_booking/db/entities/order/order.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/pricing/free_good_exclusives/free_goods_exclusives.dart';
import 'package:order_booking/db/entities/pricing/free_good_groups/free_good_groups.dart';
import 'package:order_booking/db/entities/pricing/free_good_masters/free_good_masters.dart';
import 'package:order_booking/db/entities/pricing/free_goods_detail/free_goods_detail.dart';
import 'package:order_booking/db/entities/pricing/price_access_sequence/price_access_sequence.dart';
import 'package:order_booking/db/entities/pricing/price_condition_class/price_condition_class.dart';
import 'package:order_booking/db/entities/pricing/price_condition_detail/price_condition_detail.dart';
import 'package:order_booking/db/entities/pricing/price_condition_entities/price_condition_entities.dart';
import 'package:order_booking/db/entities/pricing/price_condition_type/price_condition_type.dart';
import 'package:order_booking/db/models/device_info_model/device_info_model.dart';
import 'package:order_booking/db/models/log_model/log_model.dart';
import 'package:order_booking/model/order_model/order_model.dart';
import 'package:order_booking/model/outlet_model/outlet_model.dart';
import 'package:order_booking/model/pricing_model/pricing_model.dart';
import 'package:order_booking/model/upload_message_model/upload_message_model.dart';
import 'package:order_booking/utils/device_info_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data_source/remote/response/api_response.dart';
import '../../db/entities/market_return_detail/market_return_detail.dart';
import '../../db/entities/merchandise/merchandise.dart';
import '../../db/entities/order_detail/order_detail.dart';
import '../../db/entities/order_status/order_status.dart';
import '../../db/entities/pricing/price_condition/price_condition.dart';
import '../../db/models/product_carton_quantity/product_carton_quantity.dart';
import '../../db/models/token_response/token_response.dart';
import '../../db/models/work_status/work_status.dart';
import '../../model/master_model/master_model.dart';
import '../../model/order_detail_model/order_detail_model.dart';
import '../../model/package_product_response_model/package_product_response_model.dart';
import '../../model/routes_outlets_response_model/route_outlet_response_model.dart';
import '../../utils/Constants.dart';
import '../../utils/PreferenceUtil.dart';
import '../../utils/enums.dart';
import '../../utils/network_manager.dart';
import '../../utils/utils.dart';

class HomeRepository {
  final PreferenceUtil _preferenceUtil;
  final ApiService _apiService;
  final RouteDao _routeDao;
  final OrderDao _orderDao;
  final PricingDao _pricingDao;
  final CustomerDao _customerDao;
  final MarketReturnsDao _marketReturnsDao;
  final TaskDao _taskDao;
  final ProductDao _productDao;
  final MerchandiseDao _merchandiseDao;

  late RxBool _onDayStart;
  final RxBool _isLoading = false.obs;
  final RxBool _targetVsAchievement = false.obs;
  final Rx<UploadMessageModel> _uploadMessages=UploadMessageModel().obs;

  List<int> outletIds = [];

  HomeRepository(this._preferenceUtil,
      this._apiService,
      this._routeDao,
      this._pricingDao,
      this._customerDao,
      this._marketReturnsDao,
      this._taskDao,
      this._orderDao,
      this._productDao, this._merchandiseDao,) {
    _onDayStart = _preferenceUtil
        .getWorkSyncData()
        .isDayStarted
        .obs;
  }


  Future<ApiResponse> saveOrder(MasterModel masterModel) {
    final String accessToken = _preferenceUtil.getToken();

    return _apiService.saveOrder(accessToken, masterModel);
  }



  void getToken() async {
    setLoading(true);
    String username = _preferenceUtil.getUsername();
    String password = _preferenceUtil.getPassword();

    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) {
      if (isOnline) {
        _apiService
            .getAccessToken("password", username, password)
            .then((response) {
          if (response.status == RequestStatus.SUCCESS) {
            // setLoading(false);

            //parse response json to dart model
            TokenResponse tokenResponse =
            TokenResponse.fromJson(jsonDecode(response.data));

            //save access token to local cache
            if (tokenResponse.accessToken != null) {
              _preferenceUtil.saveToken(tokenResponse.accessToken);
            }

            updateWorkStatus(true);
          } else if (response.statusCode == 400) {
            setLoading(false);
            onError("Incorrect Saved Credentials!.Please login again");
          } else {
            setLoading(false);
            onError(response.message.toString());
          }
        }).onError((error, stackTrace) {
          setLoading(false);
          if (error is HttpException || error is SocketException) {
            onError(Constants.NETWORK_ERROR);
          } else {
            onError(error.toString());
          }
        });
      } else {
        setLoading(false);
        onError("No Internet Connection");
      }
    });
  }

  void updateWorkStatus(bool isStart) async {
    setLoading(true);
    //check if device is not connected to internet and return
    final isOnline = await NetworkManager.getInstance().isConnectedToInternet();
    if (!isOnline) {
      onError("No Internet Connection");
      return;
    }

    List<DeviceInfoModel> deviceInfoModels = [];

    deviceInfoModels.add(DeviceInfoModel(
        key: Constants.DEVICE_NAME,
        value: await DeviceInfoUtil.getDeviceName() ?? ""));

    deviceInfoModels.add(DeviceInfoModel(
        key: Constants.DEVICE_VERSION,
        value: await DeviceInfoUtil.getDeviceVersion() ?? ""));

    deviceInfoModels.add(DeviceInfoModel(
        key: Constants.IS_DEVICE_ROOTED,
        value: "${await DeviceInfoUtil.isDeviceRooted()}"));

    //can't access device physical properties above android 10
    deviceInfoModels
        .add(DeviceInfoModel(key: Constants.DEVICE_IMEI_NUMBER, value: ""));

    // can't access device physical properties above android 10
    deviceInfoModels
        .add(DeviceInfoModel(key: Constants.DEVICE_MAC_ADDRESS, value: ""));

    deviceInfoModels.add(DeviceInfoModel(
        key: Constants.DEVICE_UNIQUE_ID,
        value: await DeviceInfoUtil.getDeviceId() ?? ""));

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final LogModel logModel = LogModel();
    logModel.deviceInfo = deviceInfoModels;
    logModel.operationTypeId = isStart ? 1 : 2;
    logModel.appVersion = /*int.parse(packageInfo.buildNumber)*/ 27;

    debugPrint(jsonEncode(logModel.toJson()));
    // setLoading(true);

    String accessToken = _preferenceUtil.getToken();
    _apiService.updateStartEndStatus(logModel, accessToken).then((response) {
      setLoading(false);

      if (response.status == RequestStatus.SUCCESS) {

        if (response.data
            .toString()
            .isNotEmpty) {
          //Parse data to LogModel
          LogModel logModel = LogModel.fromJson(jsonDecode(response.data));

          if (bool.parse(logModel.success ?? "true")) {
            WorkStatus status = _preferenceUtil.getWorkSyncData();
            status.dayStarted = isStart ? 1 : 0;
            status.syncDate = logModel.startDay!;
            _preferenceUtil.saveWorkSyncData(status);
            _onDayStart.value = isStart;
            if (isStart) {
              fetchTodayData(isStart);
            }
          } else {
            onError((logModel.errorCode == 1 || logModel.errorCode == 2)
                ? logModel.errorMessage ?? ""
                : Constants.GENERIC_ERROR);
          }
        } else {
          _onDayStart.value = isStart;
          if (isStart) {
            fetchTodayData(isStart);
          }
        }
      } else {
        onError(response.message);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      onError(error.toString());
    });
  }

  RxBool isLoading() => _isLoading;

  RxBool onDayStarted() => _onDayStart;

  void setLoading(bool value) {
    _isLoading.value = value;
    _isLoading.refresh();
  }

  void setStartDay(bool value) {
    _onDayStart.value = value;
    _onDayStart.refresh();
  }

  void onError(dynamic message) {
    // _msg.value = Event(message.toString());
    // _msg.refresh();
    showToastMessage(message);
  }

  bool isDayStarted() {
    return _preferenceUtil
        .getWorkSyncData()
        .isDayStarted;
  }

  RxBool getTargetVsAchievement() => _targetVsAchievement;

  void fetchTodayData(bool isStart) async {
    String accessToken = _preferenceUtil.getToken();

    final isOnline = await NetworkManager.getInstance().isConnectedToInternet();
    if (!isOnline) {
      setLoading(false);
      onError("No Internet Connection");
      return;
    }

    try {
      setLoading(true);
      final apiResponse = await _apiService.loadTodayRoutesOutlets(accessToken);

      if (apiResponse.status != RequestStatus.SUCCESS) {
        setLoading(false);
        onError(apiResponse.message);
        return;
      }

      var response =
      RouteOutletResponseModel.fromJson(jsonDecode(apiResponse.data));

      if (!bool.parse(response.success ?? "true")) {
        setLoading(false);
        if (response.errorMessage != null) {
          onError(response.errorMessage.toString());
        } else {
          onError(Constants.GENERIC_ERROR);
        }
        return;
      }

      if (apiResponse.data != null && response.distributionId != null) {
        _preferenceUtil.saveDistributionId(response.distributionId!);
      }

      if (apiResponse.data != null && response.organizationId != null) {
        _preferenceUtil.saveOrganizationId(response.organizationId!);
      }

      if (apiResponse.data != null && response.warehouseId != null) {
        _preferenceUtil.saveWarehouseId(response.warehouseId!);
      }

      deleteAllData()
          .then(
            (value) {
          // if (onDayStart) {
          _routeDao.deleteAllMerchandise();
          _customerDao.deleteAllCustomerInput();
          _taskDao.deleteAllTask();
          _routeDao.deleteAllPromotion();
          _routeDao.deleteAllLookUp();
          _routeDao.deleteAllRoutes();
          _routeDao.deleteAllAssets();
          _routeDao.deleteAllOutlets();

          _pricingDao.deleteAllPriceConditionClasses();
          _pricingDao.deleteAllPricingAreas();
          _pricingDao.deleteAllPriceConditionEntities();
          _pricingDao.deleteAllPriceBundles();
          _pricingDao.deletePriceCondition();
          _pricingDao.deletePriceConditionTypes();
          _pricingDao.deletePriceConditionScale();
          _pricingDao.deletePriceAccessSequence();
          _pricingDao.deletePriceConditionOutletAttribute();
          _pricingDao.deleteFreeGoodMasters();
          _pricingDao.deleteFreeGoodGroups();
          _pricingDao.deleteFreePriceConditionOutletAttribute();
          _pricingDao.deleteFreeGoodDetails();
          _pricingDao.deleteFreeGoodExclusives();
          _pricingDao.deleteFreeGoodEntityDetails();
          _pricingDao.deleteOutletAvailedFreeGoods();
          _pricingDao.deleteOutletAvailedPromotion();

          //   // remove Pricing
          //   pricingDao.deleteAllPriceConditionClasses();
          //   pricingDao.deleteAllPricingAreas();
          //   deleteAllPricing();
          // }
        },
      )
          .then(
            (value) {
          if (response.routeList != null) {
            _routeDao.insertRoutes(response.routeList!);

            _preferenceUtil.setHideCustomerInfo(response
                .systemConfiguration?.hideCustomerInfoInOrderingApp);
            _preferenceUtil.setPunchOrderInUnits(
                response.systemConfiguration?.canNotPunchOrderInUnits);
            _preferenceUtil.setTargetAchievement(
                jsonEncode(response.targetVsAchievement));
            _preferenceUtil.setShowMarketReturnsButton(
                response.systemConfiguration?.showMarketReturnsButton);

            if (response.deliveryDate != null) {
              _preferenceUtil.setDeliveryDate(response.deliveryDate!);
            }
          }
        },
      )
          .then(
            (value) {
          if (response.outletList != null) {
            _routeDao.insertOutlets(response.outletList!
                .map(
                  (outletModel) => Outlet.fromJson(outletModel.toJson()),
            )
                .toList());

            // set returnedProductTypeId in market returns and insert in database
            List<MarketReturnDetail>? returnList =
                response.marketReturnDetails;
            if (returnList != null && returnList.isNotEmpty) {
              for (MarketReturnDetail item in returnList) {
                item.returnedProductTypeId = _getTypeIdByReason(
                    item.marketReturnReasonId ?? 0,
                    response.lookUp?.marketReturnReasons);
              }
              _marketReturnsDao.insertMarketReturnDetails(returnList);
            }

            List<AvailableStock>? availableStockList =
                response.dailyOutletStock;
            if (availableStockList != null &&
                availableStockList.isNotEmpty) {
              for (OutletModel outlet in response.outletList ?? []) {
                //TODO: update available stock data in outlet
                List<AvailableStock> availableStockList = [];
                for (AvailableStock availableStock in availableStockList) {
                  if (availableStock.outletId == outlet.outletId) {
                    availableStockList.add(availableStock);
                  }
                }
                //Update avlStock Data in outlet
                outlet.avlStockDetail = availableStockList;
                _routeDao.updateOutlet(Outlet.fromJson(outlet.toJson()));
                if (outlet.outletId != null) {
                  outletIds.add(outlet.outletId!);
                }
              }
            }
          }
        },
      )
          .then(
            (value) {
          if (response.assetList != null) {
            _routeDao.insertAssets(response.assetList!);
          }
        },
      )
        /*  .then(
            (value) => _taskDao.insertTasks(response.tasks),
      )*/
          .then(
            (value) {
          if (response.promosAndFOC!=null) {
            _routeDao.insertPromotion(response.promosAndFOC!);
          }
        },
      )
          .then(
            (value) {
          if (response.lookUp != null) {
            _routeDao
                .insertLookUp(LookUp.fromJson(response.lookUp!.toJson()));
          }
        },
      )
          .then(
            (value) {
          int mobileOrderId = 1;
          for (OrderModel order in response.orders ?? []) {
            if (!outletIds.contains(order.outletId)) {
              continue;
            }
            order.id = mobileOrderId;
            _orderDao.insertOrder(Order.fromJson(order.toJson()));
            mobileOrderId++;
          }
        },
      )
          .then(
            (value) {
          // added By Husanin
          for (OrderModel order in response.orders ?? []) {
            if (!outletIds.contains(order.outletId)) {
              continue;
            }

            OrderStatus orderStatus = OrderStatus();
            orderStatus.orderId = order.serverOrderId;
            orderStatus.outletId = order.outletId;

            MasterModel masterModel = MasterModel();
            masterModel.outletId = order.outletId;
            masterModel.outletStatus = 8;

            orderStatus.synced = false;
            orderStatus.data = jsonEncode(masterModel);
            orderStatus.status = 8;
            orderStatus.orderAmount = order.payable;
            orderStatus.outletVisitEndTime = 0;
            orderStatus.outletVisitStartTime = null;
            orderStatus.requestStatus = 3;
            _orderDao.insertOrderStatus(orderStatus);
          }
        },
      )
          .then(
            (value) async {
          // added By Husanin
          int mobileOrderId = 1;
          List<ProductCartonQty> productList =
          await _productDao.getProductCartonQuantity();
          HashMap<String, int> productH = HashMap();
          if (productList.isNotEmpty) {
            for (ProductCartonQty product in productList) {
              productH[product.pkPid.toString()] =
                  product.cartonQuantity ?? 0;
            }
          }
          for (OrderModel order in response.orders ?? []) {
            if (!outletIds.contains(order.outletId)) {
              continue;
            }
            for (OrderDetailModel orderDetail in order.orderDetails ?? []) {
              //check cartonSize is null or not from the server if null and product hashMap is not null then set cartonSize from hashMap in order Detail
              if (orderDetail.cartonSize == null &&
                  productH[orderDetail.mProductId.toString()] != null) {
                orderDetail.cartonSize = productH[
                productH[orderDetail.mProductId.toString()].toString()];
              }
              orderDetail.mLocalOrderId = mobileOrderId;

              _orderDao.insertOrderItem(
                  OrderDetail.fromJson(orderDetail.toJson()));
            }
            mobileOrderId++;
          }
          _preferenceUtil.saveConfig(response.configuration);
        },
      )
          .whenComplete(
            () {
          _targetVsAchievement(
              _preferenceUtil.getTargetAchievement() != null);
          _targetVsAchievement.refresh();
        },
      )
          .onError(
            (error, stackTrace) {
          setLoading(false);
          onError(error.toString());
          error.printInfo();
        },
      );
    } catch (e) {
      setLoading(false);
      onError(e.toString());
      e.printInfo();
    }

    try {
      final productApiResponse =
      await _apiService.loadTodayPackageProduct(accessToken);

      if (productApiResponse.status != RequestStatus.SUCCESS) {
        onError(productApiResponse.message);
        setLoading(false);
        return;
      }

      final response = PackageProductResponseModel.fromJson(
          jsonDecode(productApiResponse.data));

      if (!bool.parse(response.success ?? "false") &&
          (response.packageList != null && response.packageList!.isEmpty)) {
        setLoading(false);
        onError(response.errorMessage ?? "Unable to Refresh stock");
        return;
      }

      loadPricing();

      _productDao.deleteAllPackages();
      _productDao.deleteAllProductGroups();
      _productDao.deleteAllProducts();
      _productDao.insertProductGroups(response.productGroups);
      _productDao.insertPackages(response.packageList);
      _productDao.insertProducts(response.productList);
    } catch (e) {
      setLoading(false);
      onError(Constants.GENERIC_ERROR);
      e.printInfo();
    }
  }

  int _getTypeIdByReason(int reasonId,
      List<MarketReturnReason>? returnReasons) {
    if (returnReasons == null || returnReasons.isEmpty) {
      return 0;
    }

    for (MarketReturnReason reason in returnReasons) {
      if (reason.id == reasonId) {
        return reason.returnedProductTypeId ?? 0;
      }
    }
    return 0;
  }

  Future<void> deleteAllData() async {
    _routeDao.deleteAllMerchandise();
    _customerDao.deleteAllCustomerInput();
    _marketReturnsDao.deleteAllMarketReturns();
    _taskDao.deleteAllTask();
    _routeDao.deleteAllPromotion();
    _routeDao.deleteAllLookUp();
    _routeDao.deleteAllRoutes();
    _routeDao.deleteAllAssets();
    _routeDao.deleteAllOutlets();

    _pricingDao.deleteAllPriceConditionClasses();
    _pricingDao.deleteAllPricingAreas();
    _pricingDao.deleteAllPriceConditionEntities();
    _pricingDao.deleteAllPriceBundles();
    _pricingDao.deletePriceCondition();
    _pricingDao.deletePriceConditionTypes();
    _pricingDao.deletePriceConditionScale();
    _pricingDao.deletePriceAccessSequence();
    _pricingDao.deletePriceConditionOutletAttribute();
    _pricingDao.deleteFreeGoodMasters();
    _pricingDao.deleteFreeGoodGroups();
    _pricingDao.deleteFreePriceConditionOutletAttribute();
    _pricingDao.deleteFreeGoodDetails();
    _pricingDao.deleteFreeGoodExclusives();
    _pricingDao.deleteFreeGoodEntityDetails();
    _pricingDao.deleteOutletAvailedFreeGoods();
    _pricingDao.deleteOutletAvailedPromotion();
  }

  Future<void> loadPricing() async {
    String accessToken = _preferenceUtil.getToken();

    try {
      final pricingModelResponse = await _apiService.loadPricing(accessToken);

      if (pricingModelResponse.status != RequestStatus.SUCCESS) {
        onError(pricingModelResponse.message);
        return;
      }

      final response =
      PricingModel.fromJson(jsonDecode(pricingModelResponse.data));

      // if (!(response.success ?? false)) {
      //   setLoading(false);
      //   onError("Unable to Load Pricing");
      //   return;
      // }

      _pricingDao.insertPriceConditionClasses(response.priceConditionClasses
          .map(
            (element) => PriceConditionClass.fromJson(element.toJson()),
      )
          .toList());
      _pricingDao.insertPriceConditionType(response.priceConditionTypes
          .map(
            (element) => PriceConditionType.fromJson(element.toJson()),
      )
          .toList());
      _pricingDao.insertPriceAccessSequence(response.priceAccessSequences
          .map(
            (element) => PriceAccessSequence.fromJson(element.toJson()),
      )
          .toList());
      _pricingDao.insertPriceCondition(response.priceConditions
          .map(
            (element) => PriceCondition.fromJson(element.toJson()),
      )
          .toList());
      _pricingDao.insertPriceBundles(response.priceBundles);
      _pricingDao.insertPriceConditionDetail(response.priceConditionDetails
          .map(
            (element) => PriceConditionDetail.fromJson(element.toJson()),
      )
          .toList());
      _pricingDao.insertPriceConditionEntities(response.priceConditionEntities
          .map(
            (element) => PriceConditionEntities.fromJson(element.toJson()),
      )
          .toList());
      _pricingDao.insertPriceConditionScales(response.priceConditionScales);
      _pricingDao.insertPriceConditionOutletAttributes(
          response.priceConditionOutletAttributes);
      _pricingDao
          .insertOutletAvailedPromotions(response.outletAvailedPromotions);

      if (response.freeGoodsWrapper != null) {
        _pricingDao
            .insertFreeGoodMasters(
            response.freeGoodsWrapper!.freeGoodMasters?.map((e) =>
                FreeGoodMasters.fromJson(e.toJson()),).toList());
        _pricingDao
            .insertFreeGoodGroups(
            response.freeGoodsWrapper!.freeGoodGroups?.map((e) =>
                FreeGoodGroups.fromJson(e.toJson()),).toList());
        _pricingDao.insertFreePriceConditionOutletAttributes(
            response.freeGoodsWrapper!.priceConditionOutletAttributes);
        _pricingDao
            .insertFreeGoodDetails(
            response.freeGoodsWrapper!.freeGoodDetails?.map((e) =>
                FreeGoodDetails.fromJson(e.toJson()),).toList());
        _pricingDao.insertFreeGoodExclusives(
            response.freeGoodsWrapper!.freeGoodExclusives?.map((e) =>
                FreeGoodExclusives.fromJson(e.toJson()),).toList());
        _pricingDao.insertFreeGoodEntityDetails(
            response.freeGoodsWrapper!.freeGoodEntityDetails);
        _pricingDao.insertOutletAvailedFreeGoods(
            response.freeGoodsWrapper!.outletAvailedFreeGoods);
      }

      showToastMessage("Pricing Loaded Successfully!");

      setLoading(false);
    } catch (e) {
      e.printInfo();
      onError(Constants.GENERIC_ERROR);
      setLoading(false);
    }
  }

  String getUserName()=>_preferenceUtil.getUsername();

  int? getRequestCounter()=>_preferenceUtil.getRequestCounter();

  void setRequestCounter(int? requestCounter) {
    if(requestCounter!=null) {
      _preferenceUtil.setRequestCounter(requestCounter);
    }
  }

  int getDistributionId()=>_preferenceUtil.getDistributionId();

  int? getOrganizationId()=>_preferenceUtil.getOrganizationId();

  int? getWarehouseId() =>_preferenceUtil.getWarehouseId();

  int? getDeliveryDate()=>_preferenceUtil.getDeliveryDate();

  void updateOutletVisitStatus(int outletId, int visitStatus, bool synced) {
    _routeDao.updateOutletVisitStatus(outletId,visitStatus,synced);
  }

  void updateOutlet(int statusId, int outletId) {
    _routeDao.updateOutletStatus(statusId, outletId);
  }

  Rx<UploadMessageModel> getUploadMessages() {
    return _uploadMessages;
  }
}
