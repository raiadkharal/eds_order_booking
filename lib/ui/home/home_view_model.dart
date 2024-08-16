import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/model/merchandise_model/merchandise_model.dart';
import 'package:order_booking/model/upload_message_model/upload_message_model.dart';
import 'package:order_booking/ui/home/home_repository.dart';

import '../../db/entities/market_return_detail/market_return_detail.dart';
import '../../db/entities/market_returns/market_returns.dart';
import '../../db/entities/merchandise/merchandise.dart';
import '../../db/entities/order_status/order_status.dart';
import '../../db/entities/outlet/outlet.dart';
import '../../db/models/work_status/work_status.dart';
import '../../model/market_return_model/market_return_model.dart';
import '../../model/master_model/master_model.dart';
import '../../model/merchandise_upload_model/merchandise_upload_model.dart';
import '../../status_repository.dart';
import '../../utils/Constants.dart';
import '../../utils/PreferenceUtil.dart';
import '../../utils/enums.dart';
import '../../utils/util.dart';
import '../../utils/utils.dart';
import '../market_return/market_return_repository.dart';
import '../order/order_booking_repository.dart';
import '../repository.dart';

class HomeViewModel extends GetxController {
  final HomeRepository _homeRepository;
  final PreferenceUtil _preferenceUtil;
  final Repository _repository;
  final MarketReturnRepository _returnRepository;
  final OrderBookingRepository _orderBookingRepository;
  final StatusRepository _statusRepository;

  RxString lastSyncDate = "".obs;

  int remainingTasks = 0;
  int totalTasks = 0;

  final RxBool _endDayLiveData = false.obs;

  HomeViewModel(
      this._homeRepository,
      this._preferenceUtil,
      this._repository,
      this._returnRepository,
      this._orderBookingRepository,
      this._statusRepository);

  void start() {
    _preferenceUtil.setRequestCounter(1);
    _homeRepository.getToken();
  }

  void download() {
    _homeRepository.fetchTodayData(true);
  }

  void checkDayEnd() {
    int lastSyncDate = _preferenceUtil.getWorkSyncData().syncDate;
    if (lastSyncDate != 0) {
      if (!Util.isDateToday(lastSyncDate)) {
        setStartDay(false);
      } else {
        setStartDay(true);
      }
    } else {
      setStartDay(false);
    }
  }

  Future<String?> uploadSingleOrder(int outletId) async {

    String retValue = "";
    try {
      OrderStatus? status = await _statusRepository.findOrderStatus(outletId);

      if (status != null) {
            MasterModel? model = await saveOrderObservableSync(status);
            //error(model);
            onUploadSync(model, model?.outletId, model?.outletStatus);
            if (model?.success == "true") {
            } else {
              if (model?.errorCode != 3) {
                retValue = model?.errorMessage == null
                    ? "Something went wrong.Please retry."
                    : model?.errorMessage ?? "";
              }
            }
          }
    } catch (e) {
      showToastMessage(e.toString());
    }
    return retValue;
  }

  Future<MasterModel?> saveOrderObservableSync(
      final OrderStatus orderStatus) async {
    MasterModel? masterModel = orderStatus.data != null
        ? MasterModel.fromJson(jsonDecode(orderStatus.data!))
        : null;

    String finalJson = jsonEncode(masterModel?.toJson());
    debugPrint("JSON:: $finalJson");

    if (masterModel != null) {
      debugPrint(
          "OutletId Multiple Request ${masterModel.outletId} ${_homeRepository.getUserName()}");
    }
    if (masterModel == null) {
      MasterModel model = MasterModel();
      model.success = "true";
      model.outletId = orderStatus.outletId;
      model.outletStatus = orderStatus.status;
      return model;
    }
    MasterModel? model;
    if (orderStatus.requestStatus != null && orderStatus.requestStatus! < 1) {
      //send request Counter to server to avoid duplicate requests
      masterModel.requestCounter = _homeRepository.getRequestCounter();

      //add task data to the request
      /* List<Task> taskList = pendingTasksRepository.getTasksByOutletId(masterModel.getOutletId()).blockingGet();
      if (taskList != null) {
        masterModel.setTasks(taskList);
      }*/

      //set outletCode and avlStock in master model
      Outlet outlet =
          await _statusRepository.findOutletById(masterModel.outletId ?? 0);
      masterModel.outletCode = outlet.outletCode;
      if (outlet.avlStockDetail != null) {
        masterModel.dailyOutletVisit ??=
            MerchandiseUploadModel(merchandise: MerchandiseModel());
        masterModel.dailyOutletVisit?.dailyOutletStock = outlet.avlStockDetail;
      }

      //set SalesmanId in master model
      masterModel.salesmanId = await _statusRepository.getSalesmanId();

      //add market returns
      MarketReturnsModel? marketReturnsModel =
          await createMarketReturns(masterModel, outlet);
      masterModel.marketReturns = marketReturnsModel;

      /* //that will exclude the fields with @Exclude annotation in entity model
      String json = OrderUtils.toJson(masterModel);
      MasterModel masterModel1 = new Gson().fromJson(json, MasterModel.class);*/

      _homeRepository.setRequestCounter(masterModel.requestCounter);

      final finalJson = masterModel.toJson();
      // final finalJson = Util.removeNulls(json);
      //upload order request
      final response = await _homeRepository.saveOrder(MasterModel.fromJson(finalJson));

      if (response.status == RequestStatus.ERROR) {
        showToastMessage(response.message.toString());
        return null;
      }

      model = MasterModel.fromJson(jsonDecode(response.data));

      if (model.outletId == 0) {
        model.outletId = masterModel.outletId;
      }
      if (bool.parse(model.success ?? "true")) {
        orderStatus.requestStatus = 2; //order sent
        _statusRepository.update(orderStatus);
        if (model.marketReturns != null) {
          _returnRepository.updateInvoiceIdByOutlet(
              model.outletId, model.marketReturns?.invoiceId);
          _returnRepository.addMarketReturn(MarketReturns(
              outletId: model.outletId,
              invoiceId: model.marketReturns?.invoiceId));
        }
      } else {
        if (model.errorCode == 3) {
          MasterModel errorModel = MasterModel();
          errorModel.success = "false";
          errorModel.errorMessage = model.errorMessage;
          errorModel.outletId = model.outletId;
          errorModel.outletStatus = model.outletStatus;
          errorModel.errorCode = model.errorCode;
          return errorModel;
        }
      }
    } else {
      model = MasterModel();
      model.success = "true";
      model.outletId = orderStatus.outletId;
      model.outletStatus = orderStatus.status;
    }
    if (bool.parse(model.success ?? "true")) {
      //scheduleMerchandiseJob(getApplication().getApplicationContext() , model.getOutletId() , PreferenceUtil.getInstance(getApplication()).getToken() , model.getOutletStatus()!=null? model.getOutletStatus():0);
       if (saveMerchandiseSync(model.outletId, model.outletStatus ?? 0)) {
        model.outletId = masterModel.outletId;
        model.outletStatus=orderStatus.status;
        orderStatus.imageStatus=1;
        orderStatus.requestStatus=3;// all uploaded
        _statusRepository.update(orderStatus);
        return model;
      } else {
        MasterModel errorModel = MasterModel();
        errorModel.success = "false";
        errorModel.errorMessage = "Unable to upload Merchandise";
        errorModel.outletId = orderStatus.outletId;
        errorModel.outletStatus=orderStatus.status;
        return errorModel;
//
      }
    } else {
      if (model.errorCode == 3) {
        MasterModel errorModel = MasterModel();
        errorModel.success = "false";
        errorModel.errorMessage = model.errorMessage;
        errorModel.outletId = orderStatus.outletId;
        errorModel.outletStatus = orderStatus.status;
        errorModel.errorCode = model.errorCode;
        return errorModel;
      }

//                        Toast.makeText(getApplication().getApplicationContext(), model.getErrorMessage() +"", Toast.LENGTH_SHORT).show();
      MasterModel errorModel = MasterModel();
      errorModel.success = "false";
      errorModel.errorMessage = model.errorMessage;
      errorModel.outletId = orderStatus.outletId;
      errorModel.outletStatus = orderStatus.status;
      return errorModel;
    }
    return null;
  }

  Future<MarketReturnsModel?> createMarketReturns(
      MasterModel masterModel, Outlet outlet) async {
    //market returns
    MarketReturnsModel marketReturnsModel = MarketReturnsModel();
    marketReturnsModel.salesmanId = masterModel.salesmanId;
    marketReturnsModel.distributionId = _homeRepository.getDistributionId();
    marketReturnsModel.routeId = outlet.routeId;
    marketReturnsModel.outletId = masterModel.outletId;
    marketReturnsModel.organizationId = _homeRepository.getOrganizationId();
    marketReturnsModel.warehouseId = _homeRepository.getWarehouseId();
    marketReturnsModel.orderDate = DateTime.now().millisecondsSinceEpoch;
    marketReturnsModel.deliveryDate = _homeRepository.getDeliveryDate();

    //set market returns in master model
    if (masterModel.outletId != null) {
      List<MarketReturnDetail>? marketReturnDetailsList =
          await _returnRepository
              .getMarketReturnDetailsByOutletId(masterModel.outletId);
      marketReturnsModel.marketReturnDetails = marketReturnDetailsList;
      int? invoiceId = await _returnRepository
          .getMarketReturnInvoiceIdByOutletId(masterModel.outletId);
      if (invoiceId != null) {
        marketReturnsModel.invoiceId = invoiceId;
      }
    }

//        if (marketReturnsModel.getMarketReturnDetails().size() > 0) {
//            if (marketReturnsModel.getMarketReturnDetails().get(0).getInvoiceId() != null) {
//                marketReturnsModel.setInvoiceId(marketReturnsModel.getMarketReturnDetails().get(0).getInvoiceId());
//            }
//        }

    if (marketReturnsModel.marketReturnDetails != null &&
        marketReturnsModel.marketReturnDetails!.isNotEmpty) {
      return marketReturnsModel;
    } else {
      return null;
    }
  }

  void onUploadSync(
      MasterModel? orderResponseModel, int? outletId, int? statusId) {
    if (orderResponseModel == null) return;

    if (!bool.parse(orderResponseModel.success ?? "true")) {
      //isLoading().postValue(false);
      //isUploading().postValue(false);
      if (orderResponseModel.errorCode == 3) {
        if (outletId != null && statusId != null) {
          _homeRepository.updateOutletVisitStatus(outletId, statusId, true);
        }
        //status repository update
        OrderStatus orderStatus = OrderStatus(
            outletId: outletId,
            status: statusId,
            synced: true,
            orderAmount: 0.0);
        orderStatus.imageStatus = 1;
        orderStatus.requestStatus = 3; //all items uploaded
        _statusRepository.update(orderStatus);
        if (outletId != null && statusId != null) {
          _homeRepository.updateOutlet(statusId, outletId);
        }
        return;
      }
      try {
        // errorSync(handler, orderResponseModel);
      } catch (e) {
        e.printInfo();
        showToastMessage(e.toString());
      }
      return;
    }

    if (orderResponseModel.order != null) {
      orderResponseModel.customerInput = null;
      orderResponseModel.order!.orderDetails = null;

      _orderBookingRepository
          .findOrderById(orderResponseModel.order!.mobileOrderId)
          .then(
        (order) {
          orderResponseModel.order!.payable = order.payable;
          return order;
        },
      ).then(
        (order) {
          _orderBookingRepository.updateOrder(order);
        },
      ).whenComplete(
        () {
          updateOutletTaskStatus(
              orderResponseModel.outletId, orderResponseModel.order!.payable);
          // ProductUpdateService.startProductsUpdateService(getApplication().getApplicationContext(), orderResponseModel.getOutletId());
        },
      );
    } else {
      if (outletId != null && statusId != null) {
        _homeRepository.updateOutletVisitStatus(outletId, statusId, true);
      }
      //status repository update
      OrderStatus orderStatus = OrderStatus(
          outletId: outletId, status: statusId, synced: true, orderAmount: 0.0);
      orderStatus.imageStatus = 1;
      orderStatus.requestStatus = 3; //all items uploaded
      _statusRepository.update(orderStatus);
      if (outletId != null && statusId != null) {
        _homeRepository.updateOutlet(statusId, outletId);
      }
    }
  }

  void updateOutletTaskStatus(int? outletId, double? amount) {
    if (outletId == null) return;

    _homeRepository.updateOutletVisitStatus(
        outletId, Constants.STATUS_COMPLETED, true); // 8 for completed task
    _statusRepository.updateStatus(OrderStatus(
        outletId: outletId,
        status: Constants.STATUS_COMPLETED,
        synced: true,
        orderAmount: amount));
    _homeRepository.updateOutlet(Constants.STATUS_COMPLETED, outletId);
  }

  void saveWorkSyncData(WorkStatus status) =>
      _preferenceUtil.saveWorkSyncData(status);

  void setSyncDate(String date) => lastSyncDate.value = date;

  WorkStatus getWorkSyncData() => _preferenceUtil.getWorkSyncData();

  void setStartDay(bool value) => _homeRepository.setStartDay(value);

  RxBool startDay() => _homeRepository.onDayStarted();

  bool isDayStarted() => _homeRepository.isDayStarted();

  // bool isDayStarted() =>true;

  RxBool isLoading() => _homeRepository.isLoading();

  RxBool getTargetVsAchievement() => _homeRepository.getTargetVsAchievement();

  Future<int> getUnPostedOrderCount() async {
    List<OrderStatus> orderStatuses = await _statusRepository.getOrderStatus();
    return orderStatuses.length;
  }

  Future<List<Outlet>> findAllOutlets() {
    return _statusRepository.findAllOutlets();
  }

  Future<List<Outlet>> findOutletsWithPendingTasks() {
    return _statusRepository.getOutletsWithNoVisits();
  }

  RxBool getEndDayLiveData() => _endDayLiveData;

  void setEndDayLiveData(bool value) {
    _endDayLiveData(value);
    _endDayLiveData.refresh();
  }

  bool getEndDayOnPjpCompletion() {
    // return false;
    return _preferenceUtil.getConfig().endDayOnPjpCompletion ?? false;
  }

  ConfigurationModel? getConfig() {
    return _preferenceUtil.getConfig();
  }

  void updateDayEndStatus() => _homeRepository.updateWorkStatus(false);

  String? getTargetVsAchievementData() {
    return _preferenceUtil.getTargetAchievement();
  }

  void setLoading(bool value) {
    _homeRepository.setLoading(value);
  }

  Future<int> priceConditionClassValidation() {
    return _repository.priceConditionClassValidation();
  }

  Future<int> priceConditionValidation() {
    return _repository.priceConditionValidation();
  }

  Future<int> priceConditionTypeValidation() {
    return _repository.priceConditionTypeValidation();
  }

  Future<void> handleMultipleSyncOrderSync() async {
    // isLoading().value = true;
    // isUploading().value = true;

    const String TAG = "Upload Multiple Orders:";
    // NotificationUtil.getInstance(context).showNotification();
    try {
      List<OrderStatus> orderStatuses =
          await _statusRepository.getOrderStatusEx();

      remainingTasks = orderStatuses.length;
      totalTasks = orderStatuses.length;

      if (totalTasks == 0) {
        // No pending order exists
        showToastMessage("No pending order available");
        return;
      }

      /* FirebaseCrashlytics.instance.log(jsonEncode(orderStatuses));
      FirebaseCrashlytics.instance.setCustomKey("orderStatuses", jsonEncode(orderStatuses));*/

      bool dialogVisible = true;
      getUploadMessages().value = UploadMessageModel(
        message: "Preparing to upload",
        title: "Please wait",
        subMessage: "",
        maxValue: totalTasks,
        value: 1,
        visible: dialogVisible,
      );

      for (OrderStatus orderStatus in orderStatuses) {
        Outlet? outlet = await _statusRepository
            .findOutletById(orderStatus.outletId??0);

        String message = "Uploading Data of Id: ${orderStatus.outletId}";
        if (outlet.outletName != null) {
          message = "Uploading Data of ${outlet.outletName}";
        }

        getUploadMessages().value = UploadMessageModel(
          message: message,
          title: "Please wait",
          subMessage: "",
          maxValue: totalTasks,
          value: 1,
          visible: dialogVisible,
        );

        MasterModel? model = await saveOrderObservableSync(orderStatus);

        onUploadSync(model, model?.outletId, model?.outletStatus);

        if (bool.parse(model?.success ?? "true")) {
          remainingTasks--;
        } else {
          if (model?.errorCode != 3) {
            showToastMessage(model?.errorMessage ?? "");
          }
        }
      }

      getUploadMessages().value = UploadMessageModel(
        message: "All orders uploaded",
        title: "Please wait",
        subMessage: "",
        maxValue: totalTasks,
        value: 1,
        visible: false,
      );

      showToastMessage("All orders uploaded");
    } catch (e) {
      getUploadMessages().value = UploadMessageModel(
        message: "Error Occurred",
        title: "Please wait",
        subMessage: "",
        maxValue: 1,
        value: 1,
        visible: false,
      );
      showToastMessage("Error Occurred: $e");
    }
  }

  Rx<UploadMessageModel> getUploadMessages() {
    return _homeRepository.getUploadMessages();
  }

  bool saveMerchandiseSync(int? outletId, int statusId) {
    //TODO-implement this method later
    return true;
  }
}
