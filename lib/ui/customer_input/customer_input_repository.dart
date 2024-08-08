import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/entities/customer_input/customer_input.dart';
import 'package:order_booking/db/entities/merchandise/merchandise.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';

import '../../db/dao/customer_dao.dart';
import '../../db/dao/merchandise_dao.dart';

class CustomerInputRepository {
  final RouteDao _routeDao;
  final CustomerDao _customerDao;
  final MerchandiseDao _merchandiseDao;

  CustomerInputRepository(this._routeDao, this._customerDao, this._merchandiseDao);

  Rx<Outlet?> getOutletById(int? outletId) {
    Rx<Outlet?> outlet = Rx<Outlet?>(null);

    _routeDao.getOutletById(outletId ?? 0).then(
      (value) {
        outlet(value);
      },
    );

    return outlet;
  }

  Future<void> saveCustomerInput(CustomerInput customerInput) async{
    _customerDao.insertCustomerInput(customerInput);
  }

  Future<Merchandise?> findMerchandiseByOutletId(int outletId) {
  return _merchandiseDao.findMerchandiseByOutletId(outletId);
  }
}
