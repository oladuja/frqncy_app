import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/morning_card.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final List<Map<String, dynamic>> morningList = [
    {
      "image": "assets/images/morning_meditation.png",
      "title": "Energizing Morning Meditation",
      "subtitle": "Wake up feeling positive and ready to embrace the day.",
    },
    {
      "image": "assets/images/good_morning_gratitude.png",
      "title": "Good Morning Gratitude",
      "subtitle": "Relax and train your body to be free of anxiety.",
    },
    {
      "image": "assets/images/wake_up_happy.png",
      "title": "Wake Up Feeling Happy",
      "subtitle":
          "Boost your mood and cultivate a joyful start to your morning.",
    },
  ];

  final List<Map<String, dynamic>> daytimeList = [
    {
      "image": "assets/images/relaxing_meditation.png",
      "title": "Relaxing 5-Min Meditation",
      "subtitle": "Keep your energy levels high throughout the day.",
    },
    {
      "image": "assets/images/step_into_new_you.png",
      "title": "Step Into the New You!",
      "subtitle": "Break free from stress and embrace a fresh mindset.",
    },
  ];

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

  String fullDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Good ${getTimeOfDay()}, Bennett!",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.favorite_border, color: Colors.white),
                    Gap(16),
                    Icon(Icons.notifications_none, color: Colors.white),
                  ],
                ),
              ],
            ),
            Gap(24),
            Text(
              "${getTimeOfDay()}:\nStart Your Day Right!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10),
            Text(
              fullDate,
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            Gap(24),
            ...morningList.map((item) => MorningCard(item: item)),
            Gap(24),
            Text(
              "Daytime:\nStay Focused & Stress-Free!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10),
            Text(
              "You've started your day well, lets maintain the energy",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            Gap(24),
            ...daytimeList.map((item) => MorningCard(item: item)),
          ],
        ),
      ),
    );
  }
}
