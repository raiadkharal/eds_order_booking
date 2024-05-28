import 'package:flutter/material.dart';

import 'NavDrawerHeader.dart';
import 'NavDrawerItem.dart';

class NavDrawer extends StatelessWidget {
  final BuildContext baseContext;

  const NavDrawer({super.key, required this.baseContext});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            NavDrawerHeader(),
            NavDrawerItemList(context: baseContext)
          ],
        ),
      ),
    ));
  }
}
