import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/cash_memo/cash_memo_screen.dart';
import 'package:order_booking/ui/customer_input/customer_input_screen.dart';
import 'package:order_booking/ui/home/home_screen.dart';
import 'package:order_booking/ui/login/login_screen.dart';
import 'package:order_booking/ui/market_return/market_return_screen.dart';
import 'package:order_booking/ui/order/order_booking_screen.dart';
import 'package:order_booking/ui/reports/reports_screen.dart';
import 'package:order_booking/ui/reports/stock/stock_screen.dart';
import 'package:order_booking/ui/route/outlet/merchandising/asset_verification/asset_verification_screen.dart';
import 'package:order_booking/ui/route/outlet/merchandising/merchandising_screen.dart';
import 'package:order_booking/ui/route/outlet/outlet_detail/outlet_detail_screen.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_screen.dart';
import 'package:order_booking/ui/route/routes/routes_screen.dart';
import 'package:order_booking/ui/splash_screen.dart';
import 'package:order_booking/ui/task/pending_task_screen.dart';
import 'package:order_booking/ui/upload_orders/upload_orders_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'EDS Order Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: EdsRoutes.splash,
      getPages: [
        GetPage(
            name: EdsRoutes.splash,
            page: () => const SplashScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.login,
            page: () => const LoginScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.home,
            page: () => const HomeScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.routes,
            page: () => const RoutesScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.outletList,
            page: () => const OutletListScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.outletDetail,
            page: () => const OutletDetailScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.outletMerchandising,
            page: () => const MerchandisingScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.pendingTask,
            page: () => const PendingTaskScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.assetVerification,
            page: () => const AssetVerificationScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.orderBooking,
            page: () => const OrderBookingScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.cashMemo,
            page: () => const CashMemoScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.upload,
            page: () => const UploadOrdersScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.reports,
            page: () => const ReportsScreen(),
            transition: Transition.fadeIn),
        GetPage(
            name: EdsRoutes.stock,
            page: () => const StockScreen(),
            transition: Transition.fadeIn),
        GetPage(
            name: EdsRoutes.marketReturn,
            page: () => const MarketReturnScreen(),
            transition: Transition.fadeIn),
        GetPage(
            name: EdsRoutes.customerInput,
            page: () => const CustomerInputScreen(),
            transition: Transition.rightToLeft),
      ],
    );
  }
}
