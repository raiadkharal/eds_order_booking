import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:order_booking/model/order_detail_and_price_breakdown/order_detail_and_price_breakdown.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/reports/quantity.dart';
import 'package:order_booking/ui/reports/report_model.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_repository.dart';

import '../../db/entities/order_detail/order_detail.dart';
import '../../db/entities/route/route.dart';
import '../order/order_manager.dart';

class ReportsViewModel extends GetxController {
  final OutletDetailRepository _detailRepository;
  final OutletListRepository _repository;
  final StatusRepository _statusRepository;
  RxBool isLoading = false.obs;

  ReportModel reportModel = ReportModel();

  Rx<ReportModel> summaryLiveData = ReportModel().obs;

  double total = 0.0, confirmedTotal = 0.0;
  double carton = 0.0, confirmedCarton = 0.0;

  List<Quantity> orderDetailList = []; // this list is sku based
  List<Quantity> confirmedOrderDetailList = [];

  int totalOrder = 0;
  int pjpCount = 0;
  int pendingCount = 0;
  int completedCount = 0;
  int productiveCount = 0;
  int confirmedOrderCount = 0;
  double totalSku = 0;
  int syncCount = 0;

  ReportsViewModel(
      this._detailRepository, this._statusRepository, this._repository);

  RxList<MRoute> getRoutes() {
    final RxList<MRoute> routeList = RxList();
    _detailRepository.getRoutes().then(
      (routes) {
        routeList(routes);
      },
    );
    return routeList;
  }

  void getReport() async {
    setLoading(true);

    await _getPjpCount();

    _repository.getOrders().then(
      (orderModelList) {
        totalOrder = orderModelList.length;

        for (OrderEntityModel orderDetail in orderModelList) {
          bool isOrderSynced = false;
          double price = orderDetail.order?.payable ?? 0.0;
          total += price;
          if (orderDetail.order?.orderStatus == 1) {
            isOrderSynced = true;
            confirmedTotal += price;
            confirmedOrderCount += 1;
          }

          totalSku = totalSku +
              (orderDetail.orderDetailAndCPriceBreakdowns?.length ?? 0);

          if (orderDetail.orderDetailAndCPriceBreakdowns != null) {
            for (OrderDetailAndPriceBreakdown detailAndPriceBreakdown
                in orderDetail.orderDetailAndCPriceBreakdowns!) {
              OrderDetail orderItem = detailAndPriceBreakdown.orderDetail;
              int? cQty = orderItem.mCartonQuantity;
              int? uQty = orderItem.mUnitQuantity;
              cQty = cQty ?? 0;
              uQty = uQty ?? 0;

              double quantity = OrderManager.getInstance()
                  .calculateQtyInCartons(orderItem.cartonSize, uQty, cQty);
              Quantity qty =
                  Quantity(itemId: orderItem.mProductId, quantity: quantity);

              if (orderDetailList
                  .contains(Quantity(itemId: orderItem.mProductId))) {
                int pos = orderDetailList
                    .indexOf(Quantity(itemId: orderItem.mProductId));
                Quantity savedItem = orderDetailList[pos];
                double newQty = savedItem.quantity ?? 0 + quantity;
                orderDetailList[pos].quantity = newQty;
              } else {
                orderDetailList.add(qty);
              }

              if (isOrderSynced) {
                Quantity confirmQty =
                    Quantity(itemId: orderItem.mProductId, quantity: quantity);
                if (confirmedOrderDetailList
                    .contains(Quantity(itemId: orderItem.mProductId))) {
                  int pos = confirmedOrderDetailList
                      .indexOf(Quantity(itemId: orderItem.mProductId));
                  Quantity savedItem = confirmedOrderDetailList[pos];
                  double newQty = savedItem.quantity ?? 0 + quantity;
                  confirmedOrderDetailList[pos].quantity = newQty;
                } else {
                  confirmedOrderDetailList.add(confirmQty);
                }
              }
            }
          }
        }
      },
    ).onError((error, stackTrace) {
      summaryLiveData(_setSummary(total,confirmedTotal,carton,confirmedCarton,totalOrder,confirmedOrderCount, totalSku,syncCount)); // orderDetailList.size()
    },).whenComplete(() async {
      for (Quantity item in orderDetailList) {
        carton+=item.quantity??0;
      }

      for (Quantity item in confirmedOrderDetailList) {
        confirmedCarton+=item.quantity??0;
      }
      int syncedCount= await _statusRepository.getTotalSyncCount();
      syncCount=syncedCount;
      summaryLiveData(_setSummary(total,confirmedTotal,carton,confirmedCarton,totalOrder,confirmedOrderCount, totalSku,syncCount)); // orderDetailList.size()
    },);
  }

  Future<void> _getPjpCount() async {
    pjpCount = await _repository.getPjpCount();
    completedCount = await _repository.getCompletedCount();
    productiveCount = await _repository.getProductiveCount();
    pendingCount = await _repository.getPendingCount();
    reportModel.setCounts(
        pjpCount, completedCount, productiveCount, pendingCount);
    // summaryLiveData(reportModel);
  }

  ReportModel _setSummary(double total,double confirmedTotal,double carton,double confirmedCartons,int totalOrder,int confirmedOrder,double totalSku, int syncCount){ //skuSize

    reportModel.setTotalSale(total);
    reportModel.setTotalSaleConfirm(confirmedTotal);
    reportModel.setCarton(carton);
    reportModel.setCartonConfirm(confirmedCartons);
       // reportModel.setSkuSize(skuSize);
    reportModel.setTotalSku(totalSku);
    reportModel.setTotalOrders(totalOrder);
    reportModel.setTotalConfirmOrders(confirmedOrder);
    reportModel.setSyncCount(syncCount);

    return reportModel;
  }

  void setLoading(bool value){
    isLoading(value);
    isLoading.refresh();
  }

}
