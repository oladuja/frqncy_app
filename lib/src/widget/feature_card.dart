import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:frqncy_app/src/screens/details.dart';

class FeatureCardTwo extends StatelessWidget {
  final FeatureItem feature;

  const FeatureCardTwo({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8.h),
                Text(
                  feature.subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Gap(12.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              feature.imageAsset,
              width: 75.w,
              height: 75.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
