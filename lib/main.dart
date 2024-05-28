import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/customer_input/customer_input_screen.dart';
import 'package:order_booking/ui/home/home_screen.dart';
import 'package:order_booking/ui/login_screen.dart';

void main() {
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
      initialRoute: EdsRoutes.customerInput,
      getPages: [
        GetPage(
            name: EdsRoutes.login,
            page: () => const LoginScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.home,
            page: () => const HomeScreen(),
            transition: Transition.rightToLeft),
        GetPage(
            name: EdsRoutes.customerInput,
            page: () => const CustomerInputScreen(),
            transition: Transition.rightToLeft),
      ],
    );
  }
}
