import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/button/cutom_button.dart';
import '../../utils/Colors.dart';

class UploadOrdersScreen extends StatefulWidget {
  const UploadOrdersScreen({super.key});

  @override
  State<UploadOrdersScreen> createState() => _UploadOrdersScreenState();
}

class _UploadOrdersScreenState extends State<UploadOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            title: Expanded(
                child: Text(
              "EDS",
              style: GoogleFonts.roboto(color: Colors.white),
            ))),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order List",
                            style: GoogleFonts.roboto(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 26),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("( Current Date )",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: MaterialButton(
                      onPressed: () {},
                      color: secondaryColor,
                      child: Text(
                        "UPLOAD",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      color: primaryColor,
                      height: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset("assets/images/ic_done.png")),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Uploaded: 0/0",
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade600, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                                height: 20,
                                width: 20,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/ic_done.png"),
                                  color: Colors.red,
                                  colorBlendMode: BlendMode.color,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Pending: 0/0",
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade600, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Outlet Name + code",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      color: Colors.grey.shade600,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/ic_done.png"),
                                    color: Colors.green,
                                    colorBlendMode: BlendMode.color,
                                  ))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.grey,
                          height: 1,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            // Obx(
            //       () => controller.isLoading().value
            //       ? const SimpleProgressDialog()
            //       : const SizedBox(),
            // )
          ],
        ));
  }
}
