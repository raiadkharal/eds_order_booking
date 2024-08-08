
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Util.dart';

class AlertDialogManager {
  static final AlertDialogManager _ourInstance = AlertDialogManager._();

  static AlertDialogManager getInstance() {
    return _ourInstance;
  }

  AlertDialogManager._();

  void showLocationMissMatchAlertDialog(
      BuildContext context, LatLng currentLocation, LatLng outletLocation) {

    double distance = Util.checkMetre(currentLocation, outletLocation);

    String totalDistance = "$distance meters";
    if(distance>1000) {
      totalDistance = Util.formattedDistance(distance);
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Location Mismatch!", style: GoogleFonts.roboto()),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text("Outlet Location: ",
                            style: GoogleFonts.roboto())),
                    Expanded(
                        flex: 5,
                        child: Text(
                            "${outletLocation.latitude.toStringAsFixed(5)} / ${outletLocation.longitude.toStringAsFixed(5)}",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto()))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 3,
                        child:
                            Text("Your Location: ", style: GoogleFonts.roboto())),
                    Expanded(
                        flex: 5,
                        child: Text(
                            "${currentLocation.latitude.toStringAsFixed(5)} / ${currentLocation.longitude.toStringAsFixed(5)}",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto()))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text("Distance: ", style: GoogleFonts.roboto())),
                    Expanded(
                        flex: 5,
                        child: Text(totalDistance,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto()))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok", style: GoogleFonts.roboto(color:Colors.grey.shade800,fontSize: 18))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
