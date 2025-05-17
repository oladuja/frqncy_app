import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20.0,
              sigmaY: 50.0,
              tileMode: TileMode.mirror,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(0.4),
                selectedLabelStyle: TextStyle(fontSize: 10.sp),
                unselectedLabelStyle: TextStyle(fontSize: 10.sp),
                currentIndex: selectedIndex,
                onTap: onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/home_o.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/home.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    label: 'Today',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/meditation.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/m_o.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    label: 'Meditate',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/night.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/s_o.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    label: 'Sleep',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/explore.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/e.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/profile.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/p.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    label: 'You',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
