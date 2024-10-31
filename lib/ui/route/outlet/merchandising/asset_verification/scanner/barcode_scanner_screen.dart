// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:order_booking/ui/route/outlet/merchandising/asset_verification/scanner/scanner_overlay.dart';
//
// class BarcodeScannerScreen extends StatefulWidget {
//   const BarcodeScannerScreen({super.key});
//
//   @override
//   State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
// }
//
// class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
//   final MobileScannerController cameraController =
//   MobileScannerController(
//     autoStart: true,
//     cameraResolution: const Size.square(1080)
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final scanWindow = Rect.fromCenter(
//       center: Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2),
//       width: 300,
//       height: 200,
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Barcode Scanner'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.cameraswitch),
//             iconSize: 32.0,
//             onPressed: () => cameraController.switchCamera(),
//           ),
//         ],
//       ),
//       body: MobileScanner(
//         controller: cameraController,
//         scanWindow: scanWindow,
//         fit: BoxFit.cover,
//         overlayBuilder: (context, controller) => ScannerOverlay(scanWindow: scanWindow),
//         onDetect: (barcodeCapture) {
//           // showToastMessage(barcodeCapture.barcodes.first.rawValue.toString());
//           Get.back(result: barcodeCapture.barcodes.first.rawValue.toString());
//           // Navigator.of(context).pop();
//         },
//       ),
//     );
//   }
// }