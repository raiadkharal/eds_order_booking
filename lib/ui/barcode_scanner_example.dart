import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:order_booking/ui/route/outlet/merchandising/asset_verification/scanner/barcode_scanner_screen.dart';
import 'package:order_booking/utils/utils.dart';

void main() {
  runApp(BarcodeScannerApp());
}

class BarcodeScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const BarcodeScannerScreen(),
            ));
          },
          child: Text("Scan Barcode"),
        ),
      ),
    );
  }
}
