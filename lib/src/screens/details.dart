import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frqncy_app/src/screens/audio.dart';
import 'package:frqncy_app/src/widget/feature_card.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String barTitle;
  final String description;
  final String imageAsset;
  final List features;
  final int type;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.features,
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          Icons.volume_up_outlined,
                          size: 16.sp,
                          color: Colors.white,
                        ),
                        Gap(5.w),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
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
                              FontAwesomeIcons.lock,
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
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color(0xFF6D349E),
                      width: 2.5.w,
                    ),
                    insets: EdgeInsets.only(right: 30.w),
                  ),
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text('Recents', style: TextStyle(fontSize: 22.sp)),
                    ),
                    Tab(
                      child: Text(
                        'Features',
                        style: TextStyle(fontSize: 22.sp),
                      ),
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  dividerHeight: 0,
                ),
              ),
              SizedBox(
                height: 0.6.sh,
                child: TabBarView(
                  children: [
                    Center(
                      child: Text(
                        'Recents Coming Soon',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        final feature = features[index];
                        return (type == 2)
                            ? FeatureCardTwo(feature: feature)
                            : FeatureCard(feature: feature);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem {
  final String title;
  final String subtitle;
  final String imageAsset;

  FeatureItem({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });
}

class FeatureCard extends StatelessWidget {
  final FeatureItem feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => PlayerScreen(
                    tiile: feature.title,
                    subTitle: feature.subtitle,
                  ),
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
            Image.asset(
              feature.imageAsset,
              width: 75.w,
              height: 75.w,
              fit: BoxFit.cover,
            ),
            Gap(16.w),
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
                        feature.subtitle,
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
            Icon(Icons.lock, color: Colors.white30, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
