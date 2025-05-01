import 'dart:ui';

import 'package:flutter/material.dart';

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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
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
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(0.4),
                selectedLabelStyle: const TextStyle(fontSize: 10),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
                currentIndex: selectedIndex,
                onTap: onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/home_o.png',
                      width: 24,
                      height: 24,
                    ),

                    activeIcon: Image.asset(
                      'assets/images/home.png',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Today',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/meditation.png',
                      width: 24,
                      height: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/m_o.png',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Meditate',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/night.png',
                      width: 24,
                      height: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/s_o.png',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Sleep',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/explore.png',
                      width: 24,
                      height: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/e.png',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/profile.png',
                      width: 24,
                      height: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/p.png',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Bennett',
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
