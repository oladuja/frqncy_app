import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class TrackDescriptionPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const TrackDescriptionPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B062B),
      body: Stack(
        children: [
          // Hero Image
          Hero(
            tag: item,
            child: Container(
              height: 0.45.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Top Navigation
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, color: Colors.black),
                      Gap(16.w),
                      const Icon(Icons.share, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 0.65.sh,
              decoration:  BoxDecoration(
                color: Color(0xFF1B062B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    item['title'],
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(24.h),

                  Row(
                    children: [
                       Icon(
                        Icons.music_note,
                        size: 20.sp,
                        color: Colors.white70,
                      ),
                      Gap(6.w),
                      Text(
                        'Relaxing Sound',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                       Icon(
                        Icons.access_time,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      Gap(6.w),
                      Text(
                        '5:00 mins',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gap(24.h),
                  Text(
                    'Start your day with clarity and positivity. This guided meditation helps you set intentions, cultivate gratitude, and embrace the day with a calm, focused mind. ✨',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6D349E),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Listen Now',
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
