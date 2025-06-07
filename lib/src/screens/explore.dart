import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frqncy_app/src/screens/meditate_screen.dart';
import 'package:frqncy_app/src/screens/music_screen.dart';
import 'package:frqncy_app/src/screens/sleep_screen.dart';
import 'package:frqncy_app/src/screens/therapy_screen.dart';
import 'package:gap/gap.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // No need to get size directly now, use ScreenUtil for sizes

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            // Gap(20.h),
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Search here',
            //     hintStyle: TextStyle(color: Colors.white70, fontSize: 14.sp),
            //     prefixIcon: Padding(
            //       padding: EdgeInsets.all(18.w),
            //       child: SvgPicture.asset(
            //         'assets/svgs/search.svg',
            //         width: 17.w,
            //         height: 17.h,
            //       ),
            //     ),
            //     filled: true,
            //     fillColor: Colors.white.withOpacity(0.05),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(12.r)),
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            // ),
            Gap(30.h),
            const Text(
              'All For You',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MeditateScreen(),
                    ),
                  ),
                  title: "Meditate",
                  width: 0.45.sw,
                  assetName: 'assets/images/medidate.png',
                ),
                CategoryButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  SleepScreen()),
                  ),
                  title: "Sleep",
                  assetName: 'assets/images/sleep.png',
                  width: 0.4.sw,
                ),
              ],
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  title: "Music",
                  assetName: 'assets/images/music.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MusicScreen()),
                  ),
                  width: 0.4.sw,
                ),
                CategoryButton(
                  title: "Therapy",
                  assetName: 'assets/images/therapy.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TherapyScreen(),
                    ),
                  ),
                  width: 0.45.sw,
                ),
              ],
            ),
            Gap(30.h),
            // const FeaturedMeditation(),
            // Gap(30.h),
            const SectionCard(title: 'Podcast', assetName: 'assets/svgs/podcast.svg'),
            const SectionCard(
              title: 'Better Sleep Essentials',
              assetName: 'assets/svgs/sleep.svg',
            ),
            const SectionCard(
              title: 'Building healthier Family Relationship',
              assetName: 'assets/svgs/family.svg',
            ),
            const SectionCard(
              title: 'Mental Strength Training with FRQNCY',
              assetName: 'assets/svgs/mental.svg',
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;
  final double width;
  final String assetName;
  final void Function()? onTap;

  const CategoryButton({
    super.key,
    required this.title,
    required this.width,
    required this.assetName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4.w),
        height: 60.h,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetName),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturedMeditation extends StatelessWidget {
  const FeaturedMeditation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: const DecorationImage(
          image: AssetImage('assets/images/guided.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Managing Anxiety",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(8.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "GUIDED MEDITATIONS",
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          Gap(8.h),
          Row(
            children: [
              Icon(Icons.star, size: 16.sp, color: Colors.white),
              Gap(4.w),
              Text("Beginner Level", style: TextStyle(color: Colors.white, fontSize: 14.sp)),
            ],
          ),
          Gap(8.h),
          Row(
            children: [
              Icon(Icons.schedule, size: 16.sp, color: Colors.white),
              Gap(4.w),
              Text(
                "5 weeks | 10 mins a day",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            children: [
              Icon(Icons.person, size: 16.sp, color: Colors.white),
              Gap(4.w),
              Text("Led by Mina Starr", style: TextStyle(color: Colors.white, fontSize: 14.sp)),
            ],
          ),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String assetName;

  const SectionCard({super.key, required this.title, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(assetName, height: 75.h,width:  75.h),
          Gap(16.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16.sp),
        ],
      ),
    );
  }
}
