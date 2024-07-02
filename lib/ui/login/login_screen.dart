import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_booking/route.dart';
import 'package:order_booking/utils/utils.dart';

import '../../components/button/cutom_button.dart';
import '../../components/progress_dialog/PregressDialog.dart';
import '../../utils/Colors.dart';
import 'components/custom_password_field.dart';
import 'components/custom_text_field.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel controller = Get.find<LoginViewModel>();

  final _formKey = GlobalKey<FormState>();

  String _email = '';

  String _password = '';


  @override
  void initState() {
    setObservers();
    super.initState();
  }
  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  key: const ValueKey("email"),
                  hintText: "Email",
                  obscureText: false,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                  onSave: (value) {
                    _email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomPasswordField(
                  key: const ValueKey("password"),
                  hintText: "Password",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  onSubmitted: () {
                    _attemptLogin();
                  },
                  onSave: (password) {
                    _password = password;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => CustomButton(
                    onTap: () => _attemptLogin(),
                    fontSize: 22,
                    enabled: controller.isLoading().isFalse,
                    text: "Sign In")),
              ],
            ),
          ),
          Obx(
            () => controller.isLoading().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void _attemptLogin() {
    FocusScope.of(context).unfocus();
    // Get.offNamed(EdsRoutes.home);
    final validity = _formKey.currentState?.validate();
    if (validity!) {
      _formKey.currentState?.save();
      controller.login(
        _email,
        _password,
        (success) {
          if (success) {
            // If login success, navigate to main screen
            Get.offNamed(EdsRoutes.home);
          }
        },
      );
    }
  }

  void setObservers() {
    debounce(controller.getMessage(), (event) {
      showToastMessage(event.peekContent());
    },time: const Duration(milliseconds: 200));
  }
}
