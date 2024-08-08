
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_booking/di/bindings.dart';
import 'package:order_booking/route.dart';

import '../components/progress_dialog/PregressDialog.dart';
import '../utils/PreferenceUtil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: isUserAlreadyLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return const SimpleProgressDialog();

          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {

            bool loggedIn = snapshot.requireData;
            if (loggedIn) {
              // User Already logged In, navigate to main screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.offNamed(EdsRoutes.home);
              });
            } else {
              //navigate to login screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Get.offNamed(EdsRoutes.customerInput);
                Get.offNamed(EdsRoutes.login);
              });
            }
            return const SimpleProgressDialog(); // Return progress dialog while waiting for navigation
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }

  Future<bool> isUserAlreadyLoggedIn() async {
    await EdsBindings().dependencies();
    PreferenceUtil preferenceUtil = Get.find();
    // return true;
    return preferenceUtil.getToken().isNotEmpty;
  }
}
