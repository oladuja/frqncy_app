import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  const FormWidget({
    super.key,
    required this.hintText,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 14,
        ),
        filled: true,

        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.11),
            width: 1,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
