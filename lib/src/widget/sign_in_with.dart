import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignInWith extends StatelessWidget {
  final String value;
  final String imagePath;
  final void Function() onTap;

  const SignInWith({
    super.key,
    required this.value,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 34.w, height: 34.w),
            Gap(12.w),
            Text(
              'Continue With $value',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
