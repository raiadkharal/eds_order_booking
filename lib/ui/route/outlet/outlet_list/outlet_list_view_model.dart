import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/models/work_status/work_status.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_repository.dart';

import '../../../../db/models/outlet_order_status/outlet_order_status.dart';

class OutletListViewModel extends GetxController {
  final OutletListRepository _repository;
  final StatusRepository _statusRepository;

  final RxList<OutletOrderStatus> pendingOutlets = RxList<OutletOrderStatus>();
  final RxList<OutletOrderStatus> visitedOutlets = RxList<OutletOrderStatus>();
  final RxList<OutletOrderStatus> productiveOutlets = RxList<OutletOrderStatus>();
  final RxList<OutletOrderStatus> outlets = RxList<OutletOrderStatus>();
  final RxList<OutletOrderStatus> filteredOutlets = RxList<OutletOrderStatus>();

  int currentTab=0,currentPjpTab=0;

  OutletListViewModel(this._repository, this._statusRepository);

  void init(){
    loadOutlets();
    _repository.getOutletStream().listen(
          (outletOrderStatusList) {
        populateOutlets(outletOrderStatusList);
      },
    );
  }

  Future<void> loadOutlets() async {
    _repository.setLoading(true);
    _repository.getPendingOutlets().then(
      (outletOrderStatusList) {
          filteredOutlets(outletOrderStatusList);
          setPendingOutlets(outletOrderStatusList);
      },
    ).whenComplete(
      () => _repository.setLoading(false),
    );

    _repository.getVisitedOutlets().then(
      (outletOrderStatusList) {
        setVisitedOutlets(outletOrderStatusList);
      },
    );

    _repository.getProductiveOutlets().then(
      (outletOrderStatusList) {
        setProductiveOutlets(outletOrderStatusList);
      },
    );
  }

  void filterOutlets(int parentTabIndex,int pjpTabIndex) {
    updateSelectedTabs(parentTabIndex,pjpTabIndex);
    if(parentTabIndex==0) {
      switch (pjpTabIndex) {
        case 0:
          filteredOutlets(pendingOutlets);
          break;
        case 1:
          filteredOutlets(visitedOutlets);
          break;
        case 2:
          filteredOutlets(productiveOutlets);
          break;
      }
    }else{
      filteredOutlets(outlets);
    }
  }

  void loadUnPlannedOutlets(int routeId) async {
    _repository.setLoading(true);
    _repository.getUnPlannedOutlets(routeId).then(
      (outletList) {
        setUnPlannedOutlets(outletList);
      },
    ).whenComplete(
      () => _repository.setLoading(false),
    );
  }

  RxBool getLoading() => _repository.getLoading();

  void populateOutlets(List<OutletOrderStatus> outlets) {
    setPendingOutlets(outlets
        .where(
          (outletOrderStatus) => outletOrderStatus.outlet?.planned == 1 && (outletOrderStatus.outlet?.statusId??0) < 2,
        )
        .toList());

    setVisitedOutlets(outlets
        .where(
          (outletOrderStatus) =>
              outletOrderStatus.outlet?.planned == 1 &&
              (outletOrderStatus.outlet?.statusId??0) >= 2 &&
              (outletOrderStatus.outlet?.statusId??0) <= 7,
        )
        .toList());

    setProductiveOutlets(outlets
        .where(
          (outletOrderStatus) => outletOrderStatus.outlet?.planned == 1 && (outletOrderStatus.outlet?.statusId??0) >= 8,
        )
        .toList());

    setUnPlannedOutlets(outlets
        .where(
          (outletOrderStatus) => outletOrderStatus.outlet?.planned == 0,
        )
        .toList());

    filterOutlets(currentTab, currentPjpTab);
  }

  void setPendingOutlets(List<OutletOrderStatus> outlets) {
    pendingOutlets(outlets);
    pendingOutlets.refresh();
  }

  void setVisitedOutlets(List<OutletOrderStatus> outlets) {
    visitedOutlets(outlets);
    visitedOutlets.refresh();
  }

  void setProductiveOutlets(List<OutletOrderStatus> outlets) {
    productiveOutlets(outlets);
    productiveOutlets.refresh();
  }

  void setUnPlannedOutlets(List<OutletOrderStatus> outletList) {
    outlets(outletList);
    outlets.refresh();
  }

  WorkStatus getWorkSyncData() {
    return _repository.getWorkSyncData();
  }

  RxBool orderTaken(int outletId) {
    RxBool orderAlreadyTaken = false.obs;
    _statusRepository.findOrderStatus(outletId).then((orderModel) {
      if (orderModel!=null) {
        orderAlreadyTaken((orderModel.status??0)>6);
      }else{orderAlreadyTaken(false);

      }
    },);

    return orderAlreadyTaken;
  }

  bool isTestUser() {
    return _statusRepository.isTestUser();
  }

  void updateSelectedTabs(int parentTabIndex, int pjpTabIndex) {
    currentTab=parentTabIndex;
    currentPjpTab=pjpTabIndex;
  }
}
