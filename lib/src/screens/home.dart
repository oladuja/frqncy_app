import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/explore.dart';
import 'package:frqncy_app/src/screens/profile_screen.dart';
import 'package:frqncy_app/src/screens/today.dart';
import 'package:frqncy_app/src/services/adapty_service.dart';
import 'package:frqncy_app/src/widget/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    TodayScreen(),
    SubscriptionPlansScreen(),
    Center(child: Text('Sleep Page')),
    ExploreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C0430),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
