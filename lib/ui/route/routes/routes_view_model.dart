import 'package:get/get.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/repository.dart';

import '../../../db/entities/route/route.dart';

class RoutesViewModel extends GetxController {
  final StatusRepository _statusRepository;

  final RxList<MRoute> routes = RxList();

  RoutesViewModel(this._statusRepository);

  Future<List<MRoute>?> loadRoutes() {
    return _statusRepository.getAllRoutes();
  }


  void updateRouteList(List<MRoute> routeList){
    routes(routeList);
    routes.refresh();
  }
/*  @override
  void onInit() {
    _statusRepository.getAllRoutes().then(
          (routeList) {
        if (routeList != null) {
          routes(routeList);
        }
      },
    );
    super.onInit();
  }*/
}
