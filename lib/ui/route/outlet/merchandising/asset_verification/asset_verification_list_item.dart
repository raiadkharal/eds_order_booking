import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/models/asset_status/asset_status.dart';

import '../../../../../utils/Constants.dart';

class AssetVerificationListItem extends StatelessWidget {
  final Asset asset;
  final List<AssetStatus> assetStatuses;
  const AssetVerificationListItem({super.key, required this.asset, required this.assetStatuses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Text(
             asset.serialNumber.toString(),
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              (asset.verified??false)?"Verified":"Pending",
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              flex: 14,
              child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Colors.white
                ),
                child: DropdownButtonFormField(
                  onChanged:(value) {},
                  isDense: true,
                  isExpanded: true,
                  decoration: InputDecoration(
                    enabled: asset.getVerified(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none),
                    border:const OutlineInputBorder(
                        borderSide: BorderSide.none),),
                  items: assetStatuses
                      .map(
                        (element) =>
                        DropdownMenuItem(
                            value: element,
                            child: Text(
                              element.value.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            )),
                  )
                      .toList(),
                ),
              )),]
        ,
      ),
    );
  }
}
