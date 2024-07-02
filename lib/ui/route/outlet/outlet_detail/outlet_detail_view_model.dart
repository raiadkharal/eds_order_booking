import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';

import '../../../../db/entities/order_status/order_status.dart';
import '../../../../db/entities/outlet/outlet.dart';
import '../../../../db/models/configuration/configurations.dart';
import '../../../../utils/util.dart';
import '../../../../utils/utils.dart';

class OutletDetailViewModel extends GetxController {

  final OutletDetailRepository _repository;
  // final StatusRepository _statusRepository;



  Outlet outlet = Outlet();
  int? selectedOutletId;
  RxBool isLocationChanged = false.obs;
  RxBool enableBtn = false.obs;
  RxBool isStartFlow = false.obs;
  RxBool isStartNotFlow = false.obs;
  RxDouble outletNearbyPos = 0.0.obs;
  int outletStatus = 0;
  final bool _hardcodedValues =false;

  OutletDetailViewModel(this._repository);


  Rx<Set<Marker>> markers = RxSet<Marker>().obs;

  void setOutlet(Outlet outlet) => this.outlet = outlet;

  // Rx<Event<String>> getMessage() => _repository.getMessage();

  Future<void> loadSelectedOutlet(
      int? selectedOutletId) async {

    if(selectedOutletId==null){
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

  void onNextClick(LatLng currentLocation,int outletVisitStartTime) {
    LatLng? outletLocation;
    if(outlet.latitude!=null&&outlet.longitude!=null) {
      outletLocation = LatLng(outlet.latitude!, outlet.longitude!);
    }

    double distance = Util.checkMetre(currentLocation, outletLocation);

    ConfigurationModel configuration = getConfiguration();

    if(_hardcodedValues){
      configuration.geoFenceRequired=true;
      configuration.geoFenceMinRadius=50;
    }else if (isTestUser()){
      configuration.geoFenceRequired=false;
    }
    if ((configuration.geoFenceRequired &&
            distance >= configuration.geoFenceMinRadius &&
            outletStatus <= 2)) {
      setOutletNearbyPos(distance);
    } else {
      outlet.visitTimeLat=currentLocation.latitude;
      outlet.visitTimeLng=currentLocation.longitude;
      outlet.visitStatus=outletStatus;
      outlet.synced= false;
      outlet.isZeroSaleOutlet=false;
      outlet.statusId=outletStatus;

      OrderStatus orderStatus   =  OrderStatus(outletId: outlet.outletId,status: outletStatus,synced: false,orderAmount: 0.0);
//            orderStatus.setOutletVisitEndTime(Calendar.getInstance().getTimeInMillis());
      orderStatus.outletVisitStartTime = outletVisitStartTime;
      orderStatus.outletLatitude = outletLocation?.latitude;
      orderStatus.outletLatitude = outletLocation?.longitude;
      orderStatus.outletDistance=distance.toInt();
      // _statusRepository.insertStatus(orderStatus);
      // repository.updateOutlet(outlet);
      // uploadStatus.postValue(outletStatus != 1);
      Get.toNamed(EdsRoutes.orderBooking,arguments: [outlet.outletId]);
    }
  }

  void onStartNotFlow(LatLng currentLocation) {
    // LatLng? outletLocation;
    // if (outlet != null) {
    //   outletLocation = LatLng(outlet!.lattitude!, outlet!.longitude!);
    // } else if (wOutlet != null) {
    //   outletLocation = LatLng(wOutlet!.lattitude!, wOutlet!.longitude!);
    // }
    //
    // double distance = Util.checkMetre(currentLocation, outletLocation);
    //
    // Configuration configuration = getConfiguration();
    //
    // if ((configuration.geoFenceRequired &&
    //         distance >= configuration.geoFenceMinRadius &&
    //         outletStatus <= 2) &&
    //     !isTestUser()) {
    //   setOutletNearbyPos(distance);
    // } else {
    //   setStartNotFlow(true);
    // }
  }

  void setOutletNearbyPos(double distance) {
    outletNearbyPos.value = distance;
    outletNearbyPos.refresh();
  }

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

  // void postMarketVisit() => _repository.saveSurvey();
  //
  // void postWorkWith(WorkWithSingletonModel singletonModel) =>
  //     _repository.postWorkWith(singletonModel);

  void updateBtn(bool value) {
    enableBtn.value = value;
    enableBtn.refresh();
  }

  // Configuration getConfiguration() => _repository.getConfiguration();

  void updateOutletStatusCode(int code) => outletStatus = code;

  void setStartNotFlow(bool value) {
    isStartNotFlow.value = value;
    isStartNotFlow.refresh();
  }

  void loadOutletById(int outletId) async{

  }

  Future<List<Promotion>> getPromotions(int outletId) {
    return _repository.getPromotionByOutletId(outletId);
  }

  ConfigurationModel getConfiguration()=> _repository.getConfiguration();

  // void setOutletStatus(int code) => _repository.setOutletStatus(code);
  //
  // void setLoading(bool loading) => _repository.setLoading(loading);
  //
  // Rx<bool> getPostWorkWithSaved()=>_repository.postWorkWithSaved();
  //
  bool isTestUser()=>_repository.isTestUser();
}
