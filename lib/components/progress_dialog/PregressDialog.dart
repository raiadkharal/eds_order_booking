import 'package:flutter/material.dart';

import '../../utils/Colors.dart';

class SimpleProgressDialog extends StatelessWidget {
  const SimpleProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black.withOpacity(0.5),),
        const Center(
            child: Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
