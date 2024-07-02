import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final Function(String) validator;
  final Function(String) onSave;
  final Function()? onSubmitted;

  const CustomPasswordField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.onSave, this.onSubmitted});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        key: widget.key,
        obscureText: _obscureText,
        cursorColor: Colors.black,
        onFieldSubmitted: (value) => widget.onSubmitted,
        validator: (value) => widget.validator(value!),
        onSaved: (newValue) => widget.onSave(newValue!),
        textInputAction: TextInputAction.done,
        style: GoogleFonts.roboto(color: Colors.black),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
            enabledBorder: const OutlineInputBorder(
              // borderRadius:  BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.roboto(color: Colors.grey[500])),
      ),
    );
  }
}
