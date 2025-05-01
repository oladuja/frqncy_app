import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/details.dart';

class SleepScreen extends StatelessWidget {
  SleepScreen({super.key});

  final List<FeatureItem> features = [
    FeatureItem(
      title: "Sleep Essentials",
      subtitle: "How to sleep better and make a big dream",
      imageAsset: "assets/images/sleep_essentials.png",
    ),
    FeatureItem(
      title: "Guided To Sleep",
      subtitle: "How to sleep better and make a big dream",
      imageAsset: "assets/images/guided_sleep.png",
    ),
    FeatureItem(
      title: "Soundscapes",
      subtitle: "How to sleep better and make a big dream",
      imageAsset: "assets/images/soundscapes.png",
    ),
    FeatureItem(
      title: "Sleep Music",
      subtitle: "How to sleep better and make a big dream",
      imageAsset: "assets/images/sleep_music.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DetailsScreen(
      type: 2,
      barTitle: 'Sleep',
      title: "Sleep Well, Dream Big",
      description: "Sleepscast | 20 Mins",
      imageAsset: "assets/images/sleep_big.png",
      features:features,
    );
  }
}
         
