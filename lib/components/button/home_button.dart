import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData? iconData;
  final String? imagePath;
  final Color color;

  const HomeButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.iconData,
      required this.color,
      this.imagePath});

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
              iconData != null
                  ? Icon(
                      iconData,
                      size: 72,
                      color: Colors.white,
                    )
                  : Container(
                padding: const EdgeInsets.all(10),
                      width: 72,
                      height: 72,
                      child: Image(
                        image: AssetImage(imagePath ?? ""),
                        color: Colors.white,
                      )),
              Text(
                text,
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
