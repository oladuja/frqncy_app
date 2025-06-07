import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:frqncy_app/src/screens/morning_card.dart';
import 'package:frqncy_app/src/widget/loading_widget.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String? userName;
  String fullDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  Future<void> loadUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final name = doc.data()?['name'];
      if (name != null) {
        setState(() {
          userName = name;
        });
      }
    }
  }

  String getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }

  Future<List<Map<String, dynamic>>> fetchContent(String path) async {
    final snapshot = await FirebaseFirestore.instance.collection(path).get();
    return snapshot.docs
        .map((doc) => doc.data())
        .cast<Map<String, dynamic>>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: ListView(
          children: [
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Good ${getTimeOfDay()}, ${userName ?? '...'}!",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Gap(24),
            Text(
              "Start Your Day Right!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10.h),
            Text(
              fullDate,
              style: TextStyle(color: Colors.white54, fontSize: 14.sp),
            ),
            Gap(24.h),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchContent('home/inspiring/inspiring'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget();
                } else if (snapshot.hasError) {
                  return Text('Error: \${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No content available.');
                } else {
                  return Column(
                    children:
                        snapshot.data!
                            .take(3)
                            .map(
                              (item) =>
                                  MorningCard(content: Content.fromJson(item)),
                            )
                            .toList(),
                  );
                }
              },
            ),
            Gap(24.h),
            Text(
              "Stay Focused & Stress-Free!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10.h),
            Text(
              "You've started your day well, lets maintain the energy",
              style: TextStyle(color: Colors.white54, fontSize: 14.sp),
            ),
            Gap(24.h),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchContent('home/personal/personal'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget();
                } else if (snapshot.hasError) {
                  return Text('Error: \${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No content available.');
                } else {
                  return Column(
                    children:
                        snapshot.data!
                            .take(3)
                            .map(
                              (item) =>
                                  MorningCard(content: Content.fromJson(item)),
                            )
                            .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
