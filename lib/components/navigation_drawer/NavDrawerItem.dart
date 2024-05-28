
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/route.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/PreferenceUtil.dart';



class NavDrawerItemList extends StatefulWidget {
  final BuildContext context;

  const NavDrawerItemList({super.key, required this.context});

  @override
  State<NavDrawerItemList> createState() => _NavDrawerItemListState();
}

class _NavDrawerItemListState extends State<NavDrawerItemList> {

  final PreferenceUtil _preferenceUtil = Get.find<PreferenceUtil>();

  // bool isDayStarted() {
  //   return _preferenceUtil.getWorkSyncData().isDayStarted;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVersionCode(),
      builder: (context, snapshot) {
        String versionCode = snapshot.requireData;
        if(snapshot.connectionState==ConnectionState.done){
          return  Container(
            padding: const EdgeInsets.only(top: 15.0),
            // margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                menuItem(1, "My Account", FontAwesomeIcons.solidUserCircle),
                menuItem(2, "Check for Update", Icons.refresh),
                menuItem(3, "Logout", Icons.login_outlined),
                menuItem(4, "App Version ( $versionCode )",null),
                menuItem(5, "Updated on 27/05/2024",null),
              ],
            ),
          );
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget menuItem(int id, String title, IconData? icon) {
    return InkWell(
        onTap: () {
          navigate(id);
        },
        child: ListTile(
          leading: Icon(
            icon,
            size: 20,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
          ),
        ));
  }

  void navigate(int id) {
    switch (id) {
      case 1:
        Fluttertoast.showToast(msg: "Account");
        break;
      case 2:
        Fluttertoast.showToast(msg: "Update");
        break;
      case 3:
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return LogoutConfirmationDialog(
      //         onConfirm: () => logout(),
      //         onCancel: () => Navigator.of(context).pop());
      //   },
      // );
        break;
    }
  }

  Future<String> getVersionCode() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
  void logout() {
    PreferenceUtil.getInstance().then((preferenceUtil) {
      preferenceUtil.clearAllPreferences();
    });
    // Get.offAll(LoginScreen());
    Fluttertoast.showToast(msg: "Logout Success");
  }
}
