import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frqncy_app/src/screens/meditate_screen.dart';
import 'package:frqncy_app/src/screens/music_screen.dart';
import 'package:frqncy_app/src/screens/sleep_screen.dart';
import 'package:frqncy_app/src/screens/therapy_screen.dart';
import 'package:gap/gap.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const Gap(20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here',
                hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(
                    'assets/svgs/search.svg',
                    width: 17,
                    height: 17,
                  ),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Gap(30),
            const Text(
              'All For You',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Gap(20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MeditateScreen(),
                        ),
                      ),
                  title: "Meditate",
                  width: size.width * 0.45,
                  assetName: 'assets/images/medidate.png',
                ),
                CategoryButton(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  SleepScreen()),
                      ),
                  title: "Sleep",
                  assetName: 'assets/images/sleep.png',
                  width: size.width * 0.4,
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(
                  title: "Music",
                  assetName: 'assets/images/music.png',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MusicScreen()),
                      ),

                  width: size.width * 0.4,
                ),
                CategoryButton(
                  title: "Therapy",
                  assetName: 'assets/images/therapy.png',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TherapyScreen(),
                        ),
                      ),

                  width: size.width * 0.45,
                ),
              ],
            ),
            const Gap(30),
            FeaturedMeditation(),
            const Gap(30),
            SectionCard(title: 'Podcast', assetName: 'assets/svgs/podcast.svg'),
            SectionCard(
              title: 'Better Sleep Essentials',
              assetName: 'assets/svgs/sleep.svg',
            ),
            SectionCard(
              title: 'Building healthier Family Relationship',
              assetName: 'assets/svgs/family.svg',
            ),
            SectionCard(
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
        margin: const EdgeInsets.all(4),
        height: 60,
        width: width,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetName),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // gradient: const LinearGradient(
        //   colors: [Color(0xFFFA709A), Color(0xFFFEE140)],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        image: DecorationImage(
          image: AssetImage('assets/images/guided.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Managing Anxiety",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Gap(8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "GUIDED MEDITATIONS",
              style: TextStyle(fontSize: 12),
            ),
          ),
          const Gap(8),
          Row(
            children: const [
              Icon(Icons.star, size: 16, color: Colors.white),
              Gap(4),
              Text("Beginner Level", style: TextStyle(color: Colors.white)),
            ],
          ),
          const Gap(8),
          Row(
            children: const [
              Icon(Icons.schedule, size: 16, color: Colors.white),
              Gap(4),
              Text(
                "5 weeks | 10 mins a day",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: const [
              Icon(Icons.person, size: 16, color: Colors.white),
              Gap(4),
              Text("Led by Mina Starr", style: TextStyle(color: Colors.white)),
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(assetName),
          const Gap(16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        ],
      ),
    );
  }
}
