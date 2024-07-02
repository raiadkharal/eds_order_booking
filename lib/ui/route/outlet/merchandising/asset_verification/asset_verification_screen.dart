import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/components/button/cutom_button.dart';
import 'package:order_booking/ui/route/outlet/merchandising/asset_verification/asset_verification_list_item.dart';
import 'package:order_booking/utils/Constants.dart';

import '../../../../../utils/Colors.dart';

class AssetVerificationScreen extends StatefulWidget {
  const AssetVerificationScreen({super.key});

  @override
  State<AssetVerificationScreen> createState() =>
      _AssetVerificationScreenState();
}

class _AssetVerificationScreenState extends State<AssetVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "EDS",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        children: [
          Card(
            shape:
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 3,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      "Asset Code",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text(
                      "Verification",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: Text(
                      "Status",
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const AssetVerificationListItem();
                },
                itemCount: 100,
              )),
          CustomButton(onTap: () {}, text: "Barcode Scan")
        ],
      ),
    );
  }
}
