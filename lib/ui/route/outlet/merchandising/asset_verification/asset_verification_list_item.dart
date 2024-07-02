import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/Constants.dart';

class AssetVerificationListItem extends StatefulWidget {
  const AssetVerificationListItem({super.key});

  @override
  State<AssetVerificationListItem> createState() => _AssetVerificationListItemState();
}

class _AssetVerificationListItemState extends State<AssetVerificationListItem> {
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
              "RBL1709631",
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
              "Pending",
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
                  onChanged: (value) {},
                  isDense: true,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none),
                    border:OutlineInputBorder(
                        borderSide: BorderSide.none),),
                  items: Constants.assetVerificationList
                      .map(
                        (element) =>
                        DropdownMenuItem(
                            value: element,
                            child: Text(
                              element,
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
