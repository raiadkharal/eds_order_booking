import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/model/master_model/master_model.dart';
import 'package:order_booking/model/merchandise_model/merchandise_model.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/customer_input/customer_input_repository.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';
import 'package:order_booking/utils/PreferenceUtil.dart';
import 'package:workmanager/workmanager.dart';

import '../../db/entities/customer_input/customer_input.dart';
import '../../db/entities/merchandise/merchandise.dart';
import '../../db/entities/order/order.dart';
import '../../db/entities/order_status/order_status.dart';
import '../../db/models/merchandise_images/merchandise_image.dart';
import '../../model/merchandise_upload_model/merchandise_upload_model.dart';
import '../../model/order_detail_and_price_breakdown/order_detail_and_price_breakdown.dart';
import '../../model/order_response_model/order_response_model.dart';
import '../../utils/Constants.dart';

class CustomerInputViewModel extends GetxController {
  final CustomerInputRepository _repository;
  final OrderBookingRepository _orderBookingRepository;
  final StatusRepository _statusRepository;
  final PreferenceUtil _preferenceUtil;
  final RxBool _isSaving = false.obs;
  final RxBool _orderSaved = false.obs;
  final Rx<String> _msg = "".obs;
  final Rx<int?> _startSingleOrderUpdate = 0.obs;
  final RxInt _startUploadService = 0.obs;

  final Rx<OrderEntityModel?> _orderModelLiveData = Rx<OrderEntityModel?>(null);

  int? outletId;

  CustomerInputViewModel(this._repository, this._preferenceUtil,
      this._orderBookingRepository, this._statusRepository);

  int getDeliveryDate() => _preferenceUtil.getDeliveryDate();

  Rx<Outlet?> loadOutlet(int? outletId) {
    outletId = outletId;
    return _repository.getOutletById(outletId);
  }

  bool? getHideCustomerInfo() {
    return _preferenceUtil.getHideCustomerInfo();
  }

  void findOrder(int? outletId) {
    if (outletId != null) {
      final orderModel = _orderBookingRepository.findOrder(outletId);

      orderModel.then(
        (orderModel) {
          List<OrderDetail> orderDetails = [];
          if (orderModel?.orderDetailAndCPriceBreakdowns != null) {
            for (OrderDetailAndPriceBreakdown orderDetail
                in orderModel!.orderDetailAndCPriceBreakdowns!) {
              orderDetail.orderDetail.cartonPriceBreakDown =
                  orderDetail.cartonPriceBreakDownList;
              orderDetail.orderDetail.unitPriceBreakDown =
                  orderDetail.unitPriceBreakDownList;
              orderDetails.add(orderDetail.orderDetail);
            }
          }
          orderModel?.orderDetails = orderDetails;

          onOrderLoadSuccess(orderModel);

          return orderModel;
        },
      );
    }
  }

  void saveOrder(String mobileNumber, String remarks, String cnic, String strn,
      String base64sign, int deliveryDate, int? statusId) {
    setIsSaving(true);

    OrderEntityModel? orderModel = _orderModelLiveData.value;

    if (orderModel != null && orderModel.getOrder() != null) {
      // @TODO have to change logic for livedata value as it gets null on some devices
      Order? order = orderModel.getOrder();
      CustomerInput customerInput = CustomerInput(
          outletId: outletId,
          orderId: order?.id,
          mobileNumber: mobileNumber,
          cnic: cnic,
          strn: strn,
          remarks: remarks,
          signature: base64sign,
          deliveryDate: deliveryDate);

      _repository.saveCustomerInput(customerInput).then(
        (value) {
          postData(orderModel, customerInput);
        },
      );
    } else {
      findOrder(outletId);
    }
  }

  Future<void> postData(
      OrderEntityModel orderModel, CustomerInput customerInput) async {
    MasterModel data = await generateOrder(orderModel, customerInput);

    if (kDebugMode) {
      print("AssetsJson ${data.toJson()}");
    }

    OrderStatus? status = await _statusRepository
        .findOrderStatus(orderModel.outlet?.outletId ?? 0);

    OrderStatus orderStatus = OrderStatus(
        outletId: outletId,
        status: Constants.STATUS_PENDING_TO_SYNC,
        synced: false,
        orderAmount: orderModel.outlet?.lastOrder?.orderTotal ?? 0.0);

    if (status != null) {
      orderStatus.outletDistance = status.outletDistance;
      orderStatus.outletLatitude = status.outletLatitude;
      orderStatus.outletLongitude = status.outletLongitude;

      if (status.outletVisitEndTime != null) {
        orderStatus.outletVisitEndTime = status.outletVisitEndTime;
        orderStatus.outletVisitStartTime = status.outletVisitStartTime;
        data.outletEndTime = status.outletVisitEndTime;
        data.outletDistance = status.outletDistance?.toInt();
        data.outletLatitude = status.outletLatitude ?? 0.0;
        data.outletLongitude = status.outletLongitude ?? 0.0;
      } else {
        orderStatus.outletVisitEndTime = DateTime.now().millisecondsSinceEpoch;

        if (status.outletVisitStartTime != null &&
            status.outletLongitude != null &&
            status.outletLatitude != null) {
          orderStatus.outletVisitStartTime = status.outletVisitStartTime;
          data.outletDistance = status.outletDistance?.toInt();
          data.outletLatitude = status.outletLatitude;
          data.outletLongitude = status.outletLongitude;
        } else {
          // if order is already uploaded
          data.outletVisitTime = DateTime.now().millisecondsSinceEpoch;
          data.outletEndTime = status.outletVisitEndTime ?? 0;
          data.outletLatitude = status.outletLatitude ?? 0.0;
          data.outletLongitude = status.outletLongitude ?? 0.0;
          data.outletDistance = 0;
        }
      }
    }

    String finalJson = jsonEncode(data);
    orderStatus.data = finalJson;

    if (orderModel.order?.serverOrderId != null) {
      orderStatus.outletVisitStartTime = DateTime.now().millisecondsSinceEpoch;
    }

    orderStatus.requestStatus = 0;
    _statusRepository.update(orderStatus);
    _statusRepository.updateOutletVisitStatus(
        outletId, Constants.STATUS_PENDING_TO_SYNC, false);
    _statusRepository.updateOutletCnic(outletId, customerInput.mobileNumber,
        customerInput.cnic, customerInput.strn);
    _statusRepository.updateStatus(orderStatus);
    _startSingleOrderUpdate(outletId);
    _startSingleOrderUpdate.refresh();
  }

  Future<MasterModel> generateOrder(
      OrderEntityModel orderModel, CustomerInput customerInput) async {
    OrderStatus? status =
        await _statusRepository.findOrderStatus(outletId ?? 0);

    MasterModel masterModel = MasterModel();

    Order? order = orderModel.order;
    String json = jsonEncode(order);
    OrderResponseModel responseModel =
        OrderResponseModel.fromJson(jsonDecode(json));

    responseModel.orderDetails = orderModel.orderDetails
        ?.map(
          (e) => OrderDetailModel.fromJson(e.toJson()),
        )
        .toList();
    responseModel.startedDate =
        (_orderBookingRepository.getWorkSyncData().syncDate);
    masterModel.customerInput = (customerInput);
    masterModel.order = (responseModel);
    masterModel.setLocation(order?.latitude, order?.longitude);
    masterModel.outletId = order?.outletId;
    masterModel.outletStatus =
        Constants.STATUS_CONTINUE; //(assuming 8 means order complete)
    masterModel.outletVisits = orderModel.outlet?.outletVisits;

    MerchandiseUploadModel? merchandiseModel = await saveMerchandiseSync(
        masterModel.outletId!, masterModel.outletStatus!);

    masterModel.dailyOutletVisit = merchandiseModel;

    String finalJson = const JsonEncoder.withIndent('  ').convert(masterModel);

    if (kDebugMode) {
      print("JSON:: $finalJson");
    }

    if (status != null) {
      masterModel.outletVisitTime = (status.outletVisitStartTime == null
          ? DateTime.now().millisecondsSinceEpoch
          : (status.outletVisitStartTime! > 0
              ? status.outletVisitStartTime!
              : null));
    }

    if (order?.serverOrderId != null) {
      masterModel.setLocation(order?.latitude, order?.longitude);

      if (masterModel.order?.orderId != null) {
        if (masterModel.order?.orderDetails != null) {
          for (var orderDetail in masterModel.order!.orderDetails!) {
            orderDetail.mOrderId = masterModel.order?.orderId;

            if (orderDetail.cartonFreeGoods != null) {
              for (var cartonFreeGood in orderDetail.cartonFreeGoods!) {
                cartonFreeGood.mOrderId = masterModel.order?.orderId;
              }
            }
          }
        }
      }
    }

    masterModel.setOutletEndTime(DateTime.now().millisecondsSinceEpoch);
    return masterModel;
  }

  Future<MerchandiseUploadModel?> saveMerchandiseSync(
      int outletId, int statusId) async {
    Merchandise? merchandise =
        await _repository.findMerchandiseByOutletId(outletId);

    if (merchandise == null) {
      OrderStatus? orderStatus =
          await _statusRepository.findOrderStatus(outletId);
      orderStatus?.requestStatus = 3;
      // Update orderStatus in repository
      return null;
    }

    List<MerchandiseImage> readyToPostMerchandiseImagesList = [];
    Merchandise readyToPostMerchandise = Merchandise();

    if (merchandise.merchandiseImages != null) {
      for (var merchandiseImage in merchandise.merchandiseImages!) {
        if (merchandiseImage.status == 0) {
          readyToPostMerchandiseImagesList.add(merchandiseImage);
          List<String>? path = merchandiseImage.path?.split('/');
          if (path != null && path.isNotEmpty) {
            merchandiseImage.image =
                '${outletId}_${merchandiseImage.id}_${path.last}';
          }
        }
      }
    }

    readyToPostMerchandise.merchandiseImages = readyToPostMerchandiseImagesList;
    readyToPostMerchandise.assetList = merchandise.assetList;
    readyToPostMerchandise.outletId = merchandise.outletId;
    readyToPostMerchandise.remarks = merchandise.remarks;
    MerchandiseUploadModel merchandiseModel = MerchandiseUploadModel(
      merchandise: MerchandiseModel.fromJson(readyToPostMerchandise.toJson()),
      statusId: statusId,
    );

    String merchandisingJson = jsonEncode(merchandiseModel.toJson());
    if (kDebugMode) {
      print("AssetsJson: $merchandisingJson");
    }

    return merchandiseModel;
  }

  void onOrderLoadSuccess(OrderEntityModel? orderModel) {
    _orderModelLiveData(orderModel);
    _orderModelLiveData.refresh();
  }

  Rx<OrderEntityModel?> order() => _orderModelLiveData;

  RxBool getIsSaving() => _isSaving;

  RxBool orderSaved() => _orderSaved;

  Rx<String> getMessage() => _msg;

  Rx<int?> getSingleOrderUpdate() => _startSingleOrderUpdate;

  RxInt getStartUploadService() => _startUploadService;

  void setOrderSaved(bool value) {
    _orderSaved(value);
    _orderSaved.refresh();
  }

  void setIsSaving(bool value) {
    _isSaving(value);
    _isSaving.refresh();
  }

  void scheduleMerchandiseJob(int outletId, String token, int statusId) {
    Workmanager().registerOneOffTask(
      Constants.MERCHANDISE_JOB_UNIQUE_NAME, // Unique name to identify the task
      Constants.MERCHANDISE_UPLOAD_TASK,
      inputData: {
        Constants.EXTRA_PARAM_OUTLET_ID: outletId,
        Constants.EXTRA_PARAM_TOKEN: 'Bearer $token',
        Constants.EXTRA_PARAM_STATUS_ID: statusId,
      },
      initialDelay: const Duration(milliseconds: 1000),
      // Delay before the task runs
      constraints: Constraints(
        networkType: NetworkType.connected, // Require any network
      ),
    );
  }
}
