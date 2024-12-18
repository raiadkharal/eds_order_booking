import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/ui/route/routes/routes_view_model.dart';
import 'package:order_booking/utils/Colors.dart';

import '../../../db/entities/route/route.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  final RoutesViewModel _controller = Get.find<RoutesViewModel>();

  @override
  void initState() {
    _controller.loadRoutes().then(
      (routeList) {
        if (routeList != null && routeList.length == 1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offNamed(EdsRoutes.outletList, arguments: [routeList.first]);
          });
        }else{
          _controller.updateRouteList(routeList??[]);
        }

      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          "Routes",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      body: Obx(
        () => ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(EdsRoutes.outletList,
                      arguments: [_controller.routes[index]]);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${index + 1}",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            _controller.routes[index].routeName.toString(),
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            },
            itemCount: _controller.routes.length),
      ),
    );
  }
}
