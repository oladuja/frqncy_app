import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormWidget extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool obscureText;
  final bool isPassword;

  const FormWidget({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.controller,
    required this.validator,
    required this.obscureText, required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword? obscureText : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 14.sp,
        ),
        filled: true,

        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1.w,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
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
