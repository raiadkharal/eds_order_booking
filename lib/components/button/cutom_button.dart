import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double minWidth;
  final double height;
  final double fontSize;
  final MaterialAccentColor backgroundColor;
  final Color disabledColor;
  final Color textColor;
  final double cornerRadius;
  final double horizontalPadding;
  final bool enabled;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.minWidth = double.infinity,
    this.height = 36,
    this.fontSize = 16.0,
    this.cornerRadius = 2.0,
    this.backgroundColor = Colors.blueAccent,
    this.disabledColor = Colors.grey,
    this.textColor = Colors.white,
    this.horizontalPadding = 25.0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: MaterialButton(
        minWidth: minWidth,
        height: height,
        onPressed: enabled ? onTap :null,
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
        color: backgroundColor,
        disabledColor: backgroundColor.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadius)),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.roboto(
              color:textColor, fontWeight: FontWeight.w400, fontSize: fontSize),
        )),
      ),
    );
  }
}
