
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../ui/login/login_screen.dart';
import '../../utils/PreferenceUtil.dart';
import '../dialog/logout_confirmation_dialog.dart';



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
        String versionCode = snapshot.data??"";
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
                menuItem(5, "Updated on 31/10/2024",null),
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
        showToastMessage("Account");
        break;
      case 2:
        showToastMessage("Update");
        break;
      case 3:
      showDialog(
        context: context,
        builder: (context) {
          return LogoutConfirmationDialog(
              onConfirm: () => logout(),
              onCancel: () => Navigator.of(context).pop());
        },
      );
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
    Get.offAll(const LoginScreen());
    showToastMessage("Logout Success");
  }
}
