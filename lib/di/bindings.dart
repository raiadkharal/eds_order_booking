import 'package:get/get.dart';
import 'package:order_booking/db/dao/customer_dao.dart';
import 'package:order_booking/db/dao/impl/customer_dao_impl.dart';
import 'package:order_booking/db/dao/impl/market_returns_dao_impl.dart';
import 'package:order_booking/db/dao/impl/merchandise_dao_impl.dart';
import 'package:order_booking/db/dao/impl/order_dao_impl.dart';
import 'package:order_booking/db/dao/impl/order_status_dao_impl.dart';
import 'package:order_booking/db/dao/impl/price_condition_detail_dao_impl.dart';
import 'package:order_booking/db/dao/impl/pricing_dao_impl.dart';
import 'package:order_booking/db/dao/impl/product_dao_impl.dart';
import 'package:order_booking/db/dao/impl/route_dao_Imp.dart';
import 'package:order_booking/db/dao/impl/task_dao_impl.dart';
import 'package:order_booking/db/dao/market_returns_dao.dart';
import 'package:order_booking/db/dao/merchandise_dao.dart';
import 'package:order_booking/db/dao/order_dao.dart';
import 'package:order_booking/db/dao/order_status_dao.dart';
import 'package:order_booking/db/dao/price_condition_detail_dao.dart';
import 'package:order_booking/db/dao/pricing_dao.dart';
import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/dao/task_dao.dart';
import 'package:order_booking/db/database_helper.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/home/home_repository.dart';
import 'package:order_booking/ui/home/home_view_model.dart';
import 'package:order_booking/ui/market_return/market_return_repository.dart';
import 'package:order_booking/ui/order/order_booking_repository.dart';
import 'package:order_booking/ui/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../data_source/remote/api_service.dart';
import '../ui/login/login_repository.dart';
import '../ui/login/login_view_model.dart';
import '../ui/order/order_booking_view_model.dart';
import '../utils/PreferenceUtil.dart';

class EdsBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<ApiService>(ApiService(), permanent: true);
    await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance(),
        permanent: true);

    //shared preferences dependency
    Get.put<PreferenceUtil>(PreferenceUtil.getInstanceSync(Get.find()),
        permanent: true);

    //database dependency
    await Get.putAsync<Database>(() async => await DatabaseHelper.getDatabase(),
        permanent: true);

    // database dao dependencies
    Get.put<RouteDao>(RouteDaoImp(Get.find()), permanent: true);
    Get.put<CustomerDao>(CustomerDaoImpl(Get.find()), permanent: true);
    Get.put<MarketReturnsDao>(MarketReturnsDaoImpl(Get.find()),
        permanent: true);
    Get.put<OrderDao>(OrderDaoImpl(Get.find()), permanent: true);
    Get.put<PricingDao>(PricingDaoImpl(Get.find()), permanent: true);
    Get.put<ProductDao>(ProductDaoImpl(Get.find()), permanent: true);
    Get.put<TaskDao>(TaskDaoImpl(Get.find()), permanent: true);
    Get.put<MerchandiseDao>(MerchandiseDaoImpl(Get.find()), permanent: true);
    Get.put<OrderStatusDao>(OrderStatusDaoImpl(Get.find()), permanent: true);
    Get.put<PriceConditionDetailDao>(PriceConditionDetailDaoImpl(Get.find()),
        permanent: true);

    await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance(),
        permanent: true);
    Get.put<Repository>(
        Repository(Get.find(), Get.find(), Get.find(), Get.find()),
        permanent: true);
    Get.put<HomeRepository>(
        HomeRepository(
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find()),
        permanent: true);
    Get.put<StatusRepository>(StatusRepository(Get.find(), Get.find(),Get.find(),Get.find()),
        permanent: true);
    Get.put<MarketReturnRepository>(
        MarketReturnRepository(Get.find(), Get.find(), Get.find()),
        permanent: true);
    Get.put<OrderBookingRepository>(
        OrderBookingRepository(Get.find(), Get.find(), Get.find(), Get.find()),
        permanent: true);
    Get.put(OrderBookingViewModel(Get.find(), Get.find(), Get.find()),
        permanent: true);
    Get.put<HomeViewModel>(
        HomeViewModel(Get.find(), Get.find(), Get.find(), Get.find(),
            Get.find(), Get.find()),
        permanent: true);

    Get.put<LoginRepository>(
        LoginRepository.getInstance(
            Get.find(), Get.find(), Get.find(), Get.find()),
        permanent: true);
    Get.put<LoginViewModel>(LoginViewModel(Get.find(), Get.find()),
        permanent: true);
  }
}
