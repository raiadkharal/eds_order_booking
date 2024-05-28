import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/Colors.dart';

class HomeButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData iconData;
  final Color color;

  const HomeButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.iconData, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 72,
                color: Colors.white,
              ),
              Text(
                text,
                style: GoogleFonts.roboto(color: Colors.white,fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
