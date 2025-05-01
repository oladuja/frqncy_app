import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/morning_card.dart';
import 'package:frqncy_app/src/screens/settings.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B062B),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.settings_outlined, size: 24),
                    onPressed:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        ),
                  ),
                ),
            Center(
              child: const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/images/profile0.png'),
              ),
            ),
            const Gap(16),
            Center(
              child: Text(
                'Lucas Bennett',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(4),
            Center(
              child: Text(
                'Joined Feb 01, 2025',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ),
            const Gap(24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFDA5F74), Color(0xFFEFADBF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Begin Todays\nMeditations",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(8),
                  Text(
                    "Check In",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recently Played",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Discover", style: TextStyle(color: Colors.purpleAccent)),
              ],
            ),
            const Gap(12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildMiniCard(
                    title: "Meditation For Happiness",
                    subtitle: "Guided Meditation Session",
                    assetName: "assets/images/therapy.png",
                  ),
                  _buildMiniCard(
                    title: "Focus Staying On Track",
                    subtitle: "Guided Meditation Session",
                    assetName: "assets/images/music.png",
                  ),
                  _buildMiniCard(
                    title: "Meditation For Anxiety",
                    subtitle: "Guided Meditation Session",
                    assetName: "assets/images/sleep.png",
                  ),
                ],
              ),
            ),
            const Gap(30),
            const Text(
              "Activity History",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(12),
            MorningCard(
              item: {
                "image": "assets/images/morning_meditation.png",
                "title": "FRQNCY Music Jam for You!",
                "subtitle": "🎵 Music Library",
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildMiniCard({
    required String title,
    required String subtitle,
    required String assetName,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetName), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
