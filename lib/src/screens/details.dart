import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:frqncy_app/src/screens/audio.dart';
import 'package:frqncy_app/src/widget/feature_card.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String barTitle;
  final String description;
  final String imageAsset;
  final List<Content> contents;
  final int type;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.contents,
    required this.barTitle,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF1B062B),
        body: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  Image.asset(
                    imageAsset,
                    width: double.infinity,
                    height: 300.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 16.w,
                    top: 16.h,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: Center(
                      child: Text(
                        barTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "FEATURED",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                      child: Text(
                        description,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: 14.sp,

                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Gap(16.h),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6D349E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.play,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                            Gap(10.w),
                            Text('Play', style: TextStyle(fontSize: 14.sp)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Text('Listen Now', style: TextStyle(fontSize: 22.sp)),
              ),

              SizedBox(
                height: 0.6.sh,
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    final content = contents[index];
                    return (type == 2)
                        ? FeatureCardTwo(content: content)
                        : FeatureCard(content: content);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final Content content;

  const FeatureCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlayerScreen(content: content),
            ),
          ),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                content.imageUrl,
                width: 75.w,
                height: 75.w,
                fit: BoxFit.cover,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        Icons.volume_up_outlined,
                        color: Colors.white70,
                        size: 16.sp,
                      ),
                      Gap(5.w),
                      Text(
                        content.subtitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FaIcon(FontAwesomeIcons.play, color: Colors.white30, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
