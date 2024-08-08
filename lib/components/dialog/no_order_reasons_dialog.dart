import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/model/custom_object/custom_object.dart';
import 'package:order_booking/ui/order/order_booking_view_model.dart';

class NoOrderReasonsDialog extends StatelessWidget {
  final String title;
  final Function(CustomObject object) listener;
  final OrderBookingViewModel viewModel;
  final List<CustomObject> options;
  final Outlet? outlet;

  const NoOrderReasonsDialog(
      {super.key,
      required this.title,
      required this.listener,
      required this.viewModel,
      required this.outlet,
      required this.options});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ))
              ],
            ),
            Text(
              title,
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          listener(options[index]);
                          if (outlet != null) {
                            outlet!.synced = false;
                            viewModel.updateOutlet(outlet!);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            options[index].text,
                            style: GoogleFonts.roboto(fontSize: 16),
                          ),
                        ));
                  },
                  itemCount: options.length,
                ))
          ],
        ),
      ),
    );
  }
}
