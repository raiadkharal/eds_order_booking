// import 'package:flutter/material.dart';
//
// class ScannerOverlay extends StatelessWidget {
//   final Rect scanWindow;
//
//   const ScannerOverlay({Key? key, required this.scanWindow}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           color: Colors.black.withOpacity(0.5),
//         ),
//         Positioned(
//           left: scanWindow.left,
//           top: scanWindow.top,
//           width: scanWindow.width,
//           height: scanWindow.height,
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.red, width: 2),
//               color: Colors.transparent,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
