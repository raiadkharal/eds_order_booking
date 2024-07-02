import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../db/entities/promotion/promotion.dart';

class PromotionDialog extends StatelessWidget {
  final List<Promotion> promos;

  const PromotionDialog({super.key, required this.promos});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      insetPadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                  size: 30,
                ),
                const SizedBox(width: 10,),
                Text("Promotions",
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.75,
                width: MediaQuery.of(context).size.width*0.75,
              child: ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Name: ",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(promos[index].name.toString(),
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text("Amount: ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(promos[index].amount.toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(color: Colors.grey,height: 0.5,);
                  },
                  itemCount: promos.length),
            )
          ],
        ),
      ),
    );
  }
}
