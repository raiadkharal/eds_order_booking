import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_repository.dart';

import '../../../../db/models/outlet_order_status/outlet_order_status.dart';

class OutletListViewModel extends GetxController {
  final OutletListRepository _repository;

  final RxList<Outlet> pendingOutlets = RxList<Outlet>();
  final RxList<Outlet> visitedOutlets = RxList<Outlet>();
  final RxList<Outlet> productiveOutlets = RxList<Outlet>();
  final RxList<Outlet> outlets = RxList<Outlet>();
  final RxList<Outlet> pjpOutlets = RxList<Outlet>();

  OutletListViewModel(this._repository);

  @override
  void onReady() {
    loadOutlets();
    _repository.getOutletStream().listen(
      (outlets) {
        populateOutlets(outlets);
      },
    );
  }

  Future<void> loadOutlets() async {
    _repository.setLoading(true);
    _repository.getPendingOutlets().then(
      (outletsList) {
        pjpOutlets(outletsList);
        setPendingOutlets(outletsList);
      },
    ).whenComplete(
      () => _repository.setLoading(false),
    );

    _repository.getVisitedOutlets().then(
      (outletsList) {
       setVisitedOutlets(outletsList);
      },
    );

    _repository.getProductiveOutlets().then(
      (outletsList) {
       setProductiveOutlets(outletsList);
      },
    );
  }

  // Future<void> loadVisitedOutlets() async {
  //   _repository.getVisitedOutlets().then(
  //         (outletsList) {
  //       visitedOutlets(outletsList);
  //       visitedOutlets.refresh();
  //     },
  //   );
  // }
  //
  // Future<void> loadProductiveOutlets() async {
  //   _repository.getProductiveOutlets().then(
  //         (outletsList) {
  //           productiveOutlets(outletsList);
  //           productiveOutlets.refresh();
  //     },
  //   );
  // }

  void filterOutlets(int value) {
    switch (value) {
      case 0:
        pjpOutlets(pendingOutlets);
        break;
      case 1:
        pjpOutlets(visitedOutlets);
        break;
      case 2:
        pjpOutlets(productiveOutlets);
        break;
    }
  }

  //
  // void onTabChanged(int index) {
  //   switch(index){
  //     case 0:
  //       selectedTab(index);
  //       break;
  //     case 1:
  //       selectedTab(index);
  //       break;
  //   }
  // }

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

  void populateOutlets(List<Outlet> outlets) {
    setPendingOutlets(outlets
        .where(
          (outlet) => outlet.planned == 1 && outlet.statusId! < 2,
        )
        .toList());

    setVisitedOutlets(outlets
        .where(
          (outlet) => outlet.planned == 1 && outlet.statusId! >= 2 && outlet.statusId! <=7,
    )
        .toList());

    setProductiveOutlets(outlets
        .where(
          (outlet) => outlet.planned == 1 && outlet.statusId! >= 8,
    )
        .toList());

    setUnPlannedOutlets(outlets
        .where(
          (outlet) => outlet.planned == 0,
    )
        .toList());
  }

  void setPendingOutlets(List<Outlet> outlets) {
    pendingOutlets(outlets);
    pendingOutlets.refresh();
  }

  void setVisitedOutlets(List<Outlet> outlets) {
    visitedOutlets(outlets);
    visitedOutlets.refresh();
  }

  void setProductiveOutlets(List<Outlet> outlets) {
    productiveOutlets(outlets);
    productiveOutlets.refresh();
  }

  void setUnPlannedOutlets(List<Outlet> outletList) {
    outlets(outletList);
    outlets.refresh();
  }

}
