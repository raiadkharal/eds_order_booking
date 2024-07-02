import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String) validator;
  final Function(String) onSave;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.validator,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        key: key,
        obscureText: obscureText,
        cursorColor: Colors.black,
        validator: (value) => validator(value!),
        onSaved: (newValue) => onSave(newValue!),
        textInputAction: TextInputAction.next,
        style: GoogleFonts.roboto(color: Colors.black),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(color: Colors.grey.shade500)
        ),
      ),
    );
  }
}
