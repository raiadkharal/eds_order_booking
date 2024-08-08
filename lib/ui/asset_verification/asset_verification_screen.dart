/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetVerificationScreen extends StatefulWidget {
  final int outletId;
  const AssetVerificationScreen({super.key, required this.outletId});

  @override
  State<AssetVerificationScreen> createState() => _AssetVerificationScreenState();
}

class _AssetVerificationScreenState extends State<AssetVerificationScreen> {

  late final int outletId;

  @override
  void initState() {
    outletId=widget.outletId;
    if (Get.arguments != null) {
      List<dynamic> args = Get.arguments;
      outletId = args[0];
    } else {
      outletId = 0;
    }
    setObservers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 3,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex:8,
                    child: Text(
                  "Asset Code",
                  style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                )),
                Expanded(
                    flex:8,
                    child: Text(
                      "Verification",
                      style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                    )),
                Expanded(
                    flex:14,
                    child: Text(
                      "Status",
                      style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void setObservers() {}
}
*/
