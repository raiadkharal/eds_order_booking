import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_booking/di/bindings.dart';
import 'package:order_booking/route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: EdsBindings().dependencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: ElevatedButton(
                  onPressed: () => Get.toNamed(EdsRoutes.home),
                  child: const Text("Login")),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
