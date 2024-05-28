import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/utils/Colors.dart';

class CustomerInputScreen extends StatefulWidget {
  const CustomerInputScreen({super.key});

  @override
  State<CustomerInputScreen> createState() => _CustomerInputScreenState();
}

class _CustomerInputScreenState extends State<CustomerInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor,foregroundColor: Colors.white,title: Text("EDS"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("OutletName: ",style: GoogleFonts.roboto(fontSize: 14,color: Colors.black),),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Bismillah Medical Store",style: GoogleFonts.roboto(fontSize: 14,color: Colors.black54),)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
