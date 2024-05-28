import 'package:get/get.dart';
import 'package:order_booking/db/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/PreferenceUtil.dart';

class EdsBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<Database>(() async => await DatabaseHelper.getDatabase(),
        permanent: true);
    await Get.putAsync<SharedPreferences>(
            () async => await SharedPreferences.getInstance(),
        permanent: true);
    Get.put<PreferenceUtil>(PreferenceUtil.getInstanceSync(Get.find()),
        permanent: true);
  }

}