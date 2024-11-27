import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:order_booking/db/models/base_response/base_response.dart'
    as package_order_booking;
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/model/merchandise_model/merchandise_model.dart';
import 'package:order_booking/model/upload_message_model/upload_message_model.dart';
import 'package:order_booking/ui/home/home_repository.dart';

import '../../db/entities/market_return_detail/market_return_detail.dart';
import '../../db/entities/market_returns/market_returns.dart';
import '../../db/entities/merchandise/merchandise.dart';
import '../../db/entities/order_status/order_status.dart';
import '../../db/entities/outlet/outlet.dart';

import '../../db/entities/task/task.dart';
import '../../db/models/merchandise_images/merchandise_image.dart';
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
import 'package:path/path.dart' as p;

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
  final Rx<UploadMessageModel> _uploadMessages = UploadMessageModel().obs;

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
        await onUploadSync(model, model?.outletId, model?.outletStatus);
        if ((model?.success ?? "true") == "true") {
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

    String finalJson = jsonEncode(masterModel?.serialize());
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
       List<Task>? taskList = await _statusRepository.getTasksByOutletId(masterModel.outletId??0);
      if (taskList != null) {
        masterModel.tasks = taskList;
      }

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

      final finalJson = masterModel.serialize();
      // final finalJson = Util.removeNulls(json);
      //upload order request
      final response =
          await _homeRepository.saveOrder(MasterModel.fromJson(finalJson));

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
      if (await saveMerchandiseSync(model.outletId, model.outletStatus ?? 0)) {
        model.outletId = masterModel.outletId;
        model.outletStatus = orderStatus.status;
        orderStatus.imageStatus = 1;
        orderStatus.requestStatus = 3; // all uploaded
        _statusRepository.update(orderStatus);
        return model;
      } else {
        MasterModel errorModel = MasterModel();
        errorModel.success = "false";
        errorModel.errorMessage = "Unable to upload Merchandise";
        errorModel.outletId = orderStatus.outletId;
        errorModel.outletStatus = orderStatus.status;
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

  Future<void> onUploadSync(
      MasterModel? orderResponseModel, int? outletId, int? statusId) async {
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

      final order = await _orderBookingRepository
          .findOrderById(orderResponseModel.order!.mobileOrderId);

      orderResponseModel.order!.payable = order?.payable;
      order?.orderStatus = orderResponseModel.order?.orderStatusId;

      await _orderBookingRepository.updateOrder(order);

      updateOutletTaskStatus(
          orderResponseModel.outletId, orderResponseModel.order!.payable);
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

/*  Future<void> executeTasks() async {
    int totalTasks = 5;
    // controller.setTotalTasks(totalTasks);

    for (int i = 1; i <= totalTasks; i++) {
      // Simulate task execution
      await Future.delayed(Duration(seconds: 3));

      // Update the progress
      // controller.updateProgress("Task $i executing", totalTasks - i, i);

     setUploadMessage(UploadMessageModel(
        message: "Task $i executing",
        title: "Please wait",
        subMessage: "",
        maxValue: totalTasks,
        value: i,
        visible: true,
      ));
    }

    // Close the dialog when all tasks are done
    Get.back();
  }*/

  Future<void> handleMultipleSyncOrderSync() async {
    const String TAG = "Upload Multiple Orders:";
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

      bool dialogVisible = true;
      setUploadMessage(UploadMessageModel(
        message: "Preparing to upload",
        title: "Please wait",
        subMessage: "",
        maxValue: totalTasks,
        value: 1,
        visible: dialogVisible,
      ));

      int index = 0;
      for (OrderStatus orderStatus in orderStatuses) {
        index++;
        Outlet? outlet =
            await _statusRepository.findOutletById(orderStatus.outletId ?? 0);

        String message = "Uploading Data of Id: ${orderStatus.outletId}";
        if (outlet.outletName != null) {
          message = "Uploading Data of ${outlet.outletName}";
        }

        setUploadMessage(UploadMessageModel(
          message: message,
          title: "Please wait",
          subMessage: "",
          maxValue: totalTasks,
          value: index,
          visible: dialogVisible,
        ));

        // await Future.delayed(Duration(seconds: 5));

        MasterModel? model = await saveOrderObservableSync(orderStatus);

        await onUploadSync(model, model?.outletId, model?.outletStatus);

        if (bool.parse(model?.success ?? "true")) {
          remainingTasks--;
        } else {
          if (model?.errorCode != 3) {
            showToastMessage(model?.errorMessage ?? "");
          }
        }
      }

    /*  setUploadMessage(UploadMessageModel(
        message: "All orders uploaded",
        title: "Please wait",
        subMessage: "",
        maxValue: totalTasks,
        value: 1,
        visible: false,
      ));*/

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
    return _uploadMessages;
  }

  void setUploadMessage(UploadMessageModel messageModel) {
    _uploadMessages.value = messageModel;
    _uploadMessages.refresh();
  }

  Future<bool> saveMerchandiseSync(int? outletId, int statusId) async {
    Merchandise? merchandise =
        await _homeRepository.findMerchandiseById(outletId);

    if (merchandise == null) {
      OrderStatus? orderStatus =
          await _statusRepository.findOrderStatus(outletId ?? 0);
      // all data uploaded
      orderStatus?.requestStatus = 3;
      _statusRepository.update(orderStatus);
      return true;
    }

    List<MerchandiseImage> readyToPostMerchandiseImagesList = [];
    Merchandise readyToPostMerchandise = Merchandise();

    for (MerchandiseImage merchandiseImage
        in merchandise.merchandiseImages ?? []) {
      if (merchandiseImage.status == 0) {
        // Filtering merchandising images that are not uploaded
        readyToPostMerchandiseImagesList.add(merchandiseImage);

        // Splitting the path by "/"
        List<String>? path = merchandiseImage.path?.split('/');

        if (path != null && path.isNotEmpty) {
          // After Multipart
          merchandiseImage.image =
              '${outletId}_${merchandiseImage.id}_${path.last}';
        }
      }
    }

    readyToPostMerchandise.merchandiseImages = readyToPostMerchandiseImagesList;
    readyToPostMerchandise.assetList = merchandise.assetList;
    readyToPostMerchandise.outletId = outletId;
    readyToPostMerchandise.remarks = merchandise.remarks;

    MerchandiseModel readyToPostMerchandiseModel =
        MerchandiseModel.fromJson(readyToPostMerchandise.toJson());
// Passing to MerchandiseModel to upload data
    MerchandiseUploadModel merchandiseModel =
        MerchandiseUploadModel(merchandise: readyToPostMerchandiseModel);
    merchandiseModel.statusId = statusId;

    // merchandise data object ready to upload
    String merchandisingJson = jsonEncode(merchandiseModel);
    if (kDebugMode) {
      print('AssetsJson: $merchandisingJson');
    }

    OrderStatus? orderStatus;
    try {
      orderStatus = await _statusRepository.findOrderStatus(outletId ?? 0);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching order status: $e');
      }
    }

    package_order_booking.BaseResponse? baseResponse;
    bool requestAlreadySent = false;

    if ((orderStatus?.requestStatus ?? 0) < 2) {
      //post merchandise to server
      final response = await _homeRepository.postMerchandise(merchandiseModel);
      if (response.status == RequestStatus.SUCCESS) {
        //parse response data to base response model class
        baseResponse = package_order_booking.BaseResponse.fromJson(
            jsonDecode(response.data));
      }
    } else {
      baseResponse = package_order_booking.BaseResponse();
      baseResponse.success = "true";
      requestAlreadySent = true;
    }

    String iTAG = "Uploading images syc";
    if (bool.parse(baseResponse?.success ?? "true")) {
      if (orderStatus != null && !requestAlreadySent) {
        orderStatus.requestStatus = 2;
        _statusRepository.update(orderStatus);
      }

      if (kDebugMode) {
        print('Merchandise Uploaded');
      }

      bool isImageRemaining = false;

      for (MerchandiseImage merchandiseImage in merchandise.merchandiseImages ?? []) {
        if (merchandiseImage.status == 0) {
          File file = File(merchandiseImage.path ?? "");

          if (await file.exists()) {
            isImageRemaining = true;

            // Prepare multipart request
            var uri = Uri.parse('${Constants.baseUrl}route/PostImageResources');
            var request = http.MultipartRequest('POST', uri);

            final requestFile = http.MultipartFile.fromBytes(
              'file',
              await file.readAsBytes(),
              filename: p.basename(file.path),
              contentType: DioMediaType('image', '*'), // Equivalent to "image/*"
            );

            // Add the fields and files
            request.fields['imageName'] = merchandiseImage.image??"";
            request.fields['imagePath'] = merchandiseImage.path ?? "";
            // request.fields['md5'] = ''; // Add the md5 field if needed
            request.files.add(requestFile);

            try {
              // upload multipart image to the server
              var response = await http.Client().send(request);

              if (response.statusCode == 200) {
                merchandiseImage.status = 1; // Uploaded
                await file.delete();
                updateRecord(merchandise);
              } else {
                if (kDebugMode) {
                  print('Failed to upload file: ${response.statusCode}');
                }
              }
            } catch (e) {
              if (kDebugMode) {
                print("Error uploading file: $e");
              }
            }

            if (kDebugMode) {
              print('Uploaded File ${merchandiseImage.image}');
            }
          } else {
            // File already uploaded and deleted
            merchandiseImage.status = 1;
          }
        }
      }

      if (!isImageRemaining) {
        for (var merchandiseImage in merchandise.merchandiseImages ?? []) {
          if (merchandiseImage.status == 1) {
            // uploaded
            File file = File(merchandiseImage.path);
            if (await file.exists()) {
              await file.delete();
            }
          }
        }
        if (orderStatus != null) {
          orderStatus.requestStatus = 3; // all uploaded
          await _statusRepository.update(orderStatus);
        }
        // removeRecord(merchandise);
        // print('Record Removed');
      }
    } else {
      if (kDebugMode) {
        print(baseResponse?.errorMessage.toString());
      }
      return false;
    }


    return true;
  }

  void updateRecord(Merchandise merchandise) {
    _homeRepository.updateMerchandise(merchandise);
  }
}
