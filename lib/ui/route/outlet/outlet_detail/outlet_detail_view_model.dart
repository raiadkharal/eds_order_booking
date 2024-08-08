import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:order_booking/db/entities/market_returns/market_returns.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/model/market_return_model/market_return_model.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/market_return/market_return_repository.dart';
import 'package:order_booking/ui/market_return/market_return_screen.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:order_booking/utils/enums.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../db/entities/merchandise/merchandise.dart';
import '../../../../db/entities/order_status/order_status.dart';
import '../../../../db/entities/outlet/outlet.dart';
import '../../../../db/entities/task/task.dart';
import '../../../../db/models/configuration/configurations.dart';
import '../../../../db/models/merchandise_images/merchandise_image.dart';
import '../../../../model/master_model/master_model.dart';
import '../../../../model/merchandise_model/merchandise_model.dart';
import '../../../../model/order_response_model/order_response_model.dart';
import '../../../../utils/util.dart';
import '../../../../utils/utils.dart';

class OutletDetailViewModel extends GetxController {
  final OutletDetailRepository _repository;
  final StatusRepository _statusRepository;

  Outlet outlet = Outlet();
  int? selectedOutletId;
  RxBool isLocationChanged = false.obs;
  RxBool isStartFlow = false.obs;
  RxBool isStartNotFlow = false.obs;
  final RxBool _uploadStatus = false.obs;
  final RxInt _startSingleOrderUpdate = 0.obs;
  RxDouble outletNearbyPos = 0.0.obs;
  int outletStatus = 0;
  final bool _hardcodedValues = false;

  OutletDetailViewModel(this._repository, this._statusRepository);

  Rx<Set<Marker>> markers = RxSet<Marker>().obs;

  void setOutlet(Outlet outlet) => this.outlet = outlet;

  // Rx<Event<String>> getMessage() => _repository.getMessage();

  Future<void> loadSelectedOutlet(int? selectedOutletId) async {
    if (selectedOutletId == null) {
      showToastMessage("Can't load Outlet");
      return;
    }
    _repository.setLoading(true);

    try {
      final outlet = await _repository.getOutletById(selectedOutletId);
      setOutlet(outlet);
      _repository.setLoading(false);
    } catch (e) {
      _repository.setLoading(false);
      showToastMessage(e.toString());
      rethrow;
    }
  }

  void onNextClick(LatLng currentLocation, int outletVisitStartTime) {
    LatLng? outletLocation;
    if (outlet.latitude != null && outlet.longitude != null) {
      outletLocation = LatLng(outlet.latitude!, outlet.longitude!);
    }

    double distance = Util.checkMetre(currentLocation, outletLocation);

    ConfigurationModel configuration = getConfiguration();

    if (_hardcodedValues) {
      configuration.geoFenceRequired = true;
      configuration.geoFenceMinRadius = 50;
    } else if (isTestUser()) {
      configuration.geoFenceRequired = false;
    }
    if ((!configuration.geoFenceRequired &&
            distance >= configuration.geoFenceMinRadius &&
            outletStatus <= 2) &&
        !isTestUser()) {
      setOutletNearbyPos(distance);
    } else {
      outlet.visitTimeLat = currentLocation.latitude;
      outlet.visitTimeLng = currentLocation.longitude;
      outlet.visitStatus = outletStatus;
      outlet.synced = false;
      outlet.isZeroSaleOutlet = false;
      outlet.statusId = outletStatus;

      OrderStatus orderStatus = OrderStatus(
          outletId: outlet.outletId,
          status: outletStatus,
          synced: false,
          orderAmount: 0.0);
//            orderStatus.setOutletVisitEndTime(Calendar.getInstance().getTimeInMillis());
      orderStatus.outletVisitStartTime = outletVisitStartTime;
      orderStatus.outletLatitude = outletLocation?.latitude;
      orderStatus.outletLatitude = outletLocation?.longitude;
      orderStatus.outletDistance = distance.toInt();
      _statusRepository.insertStatus(orderStatus);
      _statusRepository.updateOutlet(outlet);
      setUploadStatus(outletStatus != 1);
    }
  }

  Future<void> postEmptyCheckout(bool noOrderFromBooking, int outletId,
      int outletVisitStartTime, int outletVisitEndTime) async {
    if (noOrderFromBooking) {
      outletStatus = Constants
          .STATUS_NO_ORDER_FROM_BOOKING; // 6 means no order from booking view
      outlet.synced = false;
      outlet.visitStatus = outletStatus;
      outlet.statusId = Constants.STATUS_NO_ORDER_FROM_BOOKING;
      Outlet outlet1 = await _statusRepository.findOutletById(outletId);
      outlet.avlStockDetail = outlet1.avlStockDetail;

      _statusRepository.updateOutlet(outlet);

      OrderStatus status = OrderStatus(
          outletId: outlet.outletId,
          status: outletStatus,
          synced: false,
          orderAmount: 0.0);
      status.outletVisitStartTime = outletVisitStartTime;
      status.outletVisitEndTime = outletVisitEndTime;
      _statusRepository.insertStatus(status);
      setUploadStatus(true);
    }
  }

  Future<void> postEmptyCheckoutWithOutAssetVerification(
      bool noOrderFromBooking,
      int outletId,
      int outletVisitStartTime,
      int outletVisitEndTime) async {
    if (noOrderFromBooking) {
      outletStatus = 7; // no Asset Verification
      outlet.synced = false;
      outlet.visitStatus = outletStatus;
      outlet.statusId = 7;

      Outlet outlet1 = await _statusRepository.findOutletById(outletId);
      outlet.avlStockDetail = outlet1.avlStockDetail;

      _statusRepository.updateOutlet(outlet);

      OrderStatus status = OrderStatus(
          outletId: outlet.outletId,
          status: 7,
          synced: false,
          orderAmount: 0.0);
      status.outletVisitStartTime = outletVisitStartTime;
      status.outletVisitEndTime = outletVisitEndTime;
      _statusRepository.insertStatus(status);
      setUploadStatus(true);
    }
  }

  Future<void> uploadStatus(
      int outletId,
      LatLng? currentLatLng,
      LatLng? outletLatLng,
      double distance,
      int visitDateTime,
      int visitEndTime,
      String reason) async {
    MasterModel masterModel = MasterModel();
    masterModel.outletId = outletId;
    masterModel.outletStatus = outletStatus;
    masterModel.reason = reason;
    masterModel.startedDate = _repository.getStartedDate();
    OrderResponseModel order = OrderResponseModel();
    order.startedDate = _repository.getStartedDate();
    masterModel.order = order;
    masterModel.setOutletVisitTime(visitDateTime);
    masterModel.setOutletEndTime(visitEndTime);
    masterModel.setLocation(currentLatLng?.latitude, currentLatLng?.longitude);
    masterModel.outletLatitude = outletLatLng?.latitude;
    masterModel.outletLongitude = outletLatLng?.longitude;
    masterModel.outletDistance = distance;

    MerchandiseModel? merchandiseModel = await saveMerchandiseSync(
        masterModel.outletId, masterModel.outletStatus); //get merchandise

    masterModel.dailyOutletVisit = merchandiseModel;

    //set outlet code and dailyAvlStock in master model
    Outlet outlet =
        await _statusRepository.findOutletById(masterModel.outletId ?? 0);
    masterModel.outletCode = outlet.outletCode;
    if (outlet.avlStockDetail != null) {
      masterModel.dailyOutletVisit ??=
          MerchandiseModel(merchandise: Merchandise());
      masterModel.dailyOutletVisit?.dailyOutletStock = outlet.avlStockDetail;
    }

    String finalJson = jsonEncode(masterModel.toJson());
    debugPrint("JSON:: $finalJson");

    _statusRepository.findOrderStatus(outletId).then(
      (status) {
        if (status != null) {
          status.data = finalJson;
          _statusRepository.update(status);
        }
      },
    );

    setSingleOrderUpdate(outletId);
  }

  Future<MerchandiseModel?> saveMerchandiseSync(
      int? outletId, int? statusId) async {
    Merchandise? merchandise =
        await _repository.findMerchandiseByOutletId(outletId);
    //Normalize images names
    if (merchandise == null) {
      OrderStatus? orderStatus =
          await _statusRepository.findOrderStatus(outletId ?? 0);
      // all data uploaded
      orderStatus?.requestStatus = 3;

      return null;
    }

    List<MerchandiseImage> readyToPostMerchandiseImagesList = [];
    Merchandise readyToPostMerchandise = Merchandise();
    if (merchandise.merchandiseImages != null) {
      for (MerchandiseImage merchandiseImage
          in merchandise.merchandiseImages!) {
        if (merchandiseImage.status == 0) {
          readyToPostMerchandiseImagesList.add(merchandiseImage);
          final path = merchandiseImage.path?.split("/");
          if (path != null && path.isNotEmpty) {
            // After Multipart
            merchandiseImage.image =
                "$outletId _ ${merchandiseImage.id} _ ${path[path.length - 1]}";
          }
        }
      }
    }
    readyToPostMerchandise.merchandiseImages = readyToPostMerchandiseImagesList;
    readyToPostMerchandise.assetList = merchandise.assetList;
    readyToPostMerchandise.outletId = outletId;
    readyToPostMerchandise.remarks = merchandise.remarks;
    MerchandiseModel merchandiseModel =
        MerchandiseModel(merchandise: readyToPostMerchandise);
    merchandiseModel.statusId = statusId;

    debugPrint("AssetsJson ${jsonEncode(merchandiseModel)}");

    return merchandiseModel;
  }

  void setOutletNearbyPos(double distance) {
    outletNearbyPos.value = distance;
    outletNearbyPos.refresh();
  }

  void setUploadStatus(bool value) {
    _uploadStatus(value);
    _uploadStatus.refresh();
  }

  RxBool getUploadStatus() => _uploadStatus;

  void setStartFlow(bool value) {
    isStartFlow.value = value;
    isStartFlow.refresh();
  }

  void setSelectedOutlet(int? selectedOutlet) =>
      selectedOutletId = selectedOutlet;

  RxBool isLoading() => _repository.isLoading();

  void addMarker(Marker marker) {
    markers.value.clear();
    markers.value.add(marker);
    markers.refresh();
  }

  void updateOutletStatusCode(int code) => outletStatus = code;

  void setStartNotFlow(bool value) {
    isStartNotFlow.value = value;
    isStartNotFlow.refresh();
  }

  void loadOutletById(int outletId) async {}

  Future<List<Promotion>> getPromotions(int outletId) {
    return _repository.getPromotionByOutletId(outletId);
  }

  ConfigurationModel getConfiguration() => _repository.getConfiguration();

  void setLoading(bool loading) => _repository.setLoading(loading);

  bool isTestUser() => _repository.isTestUser();

  void setSingleOrderUpdate(int? outletId) {
    _startSingleOrderUpdate(outletId);
    _startSingleOrderUpdate.refresh();
  }

  RxInt getSingleOrderUpdate() => _startSingleOrderUpdate;

  int? getSyncDate() {
    return _repository.getStartedDate();
  }

  RxList<Asset> getAssets(int outletId) {
    final RxList<Asset> assets = RxList();
    _statusRepository.getAssets(outletId).then(
      (assetList) {
        assets(assetList);
        assets.refresh();
      },
    );

    return assets;
  }

  void updateOutlet(Outlet outlet) {
    _statusRepository.updateOutlet(outlet);
  }

  void setAssetScanned(bool value) {
    _statusRepository.setAssetScanned(value);
  }

}
