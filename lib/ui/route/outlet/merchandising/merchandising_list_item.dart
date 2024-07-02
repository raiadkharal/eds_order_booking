import 'dart:io';

import 'package:flutter/material.dart';
import 'package:order_booking/db/models/merchandise_images/merchandise_image.dart';

class MerchandisingListItem extends StatelessWidget {
  final MerchandiseImage merchandiseImage;
  final VoidCallback deleteCallback;

  const MerchandisingListItem(
      {super.key,
      required this.merchandiseImage,
      required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    File imageFile = File(merchandiseImage.path ?? "");
    return SizedBox(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        child: Stack(
          children: [
            Image.file(
              imageFile,
              fit: BoxFit.fill,
            ),
            Positioned(
                top: -15,
                right: -15,
                child: IconButton(
                  color: Colors.grey,
                  icon: const Icon(Icons.close, color: Colors.white,size: 15,),
                  onPressed: deleteCallback,
                ))
          ],
        ),
      ),
    );
  }
}
