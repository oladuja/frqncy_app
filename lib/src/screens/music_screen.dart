import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/details.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsScreen(
      type: 0,
      barTitle: 'Music',
      title: "Makes a Better You!",
      description: "Therapy | 20 Mins",
      imageAsset: "assets/images/music_big.png",
      features: [
        FeatureItem(
          title: "Sleep Music",
          subtitle: "Music Library | 01:12:00",
          imageAsset: "assets/images/sleep_m.png",
        ),
        FeatureItem(
          title: "Focus Music",
          subtitle: "Music Library | 01:12:00",
          imageAsset: "assets/images/focus_music.png",
        ),
        FeatureItem(
          title: "Binaural Beats",
          subtitle: "Music Library | 01:12:00",
          imageAsset: "assets/images/binaural.png",
        ),
        FeatureItem(
          title: "Soft Piano",
          subtitle: "Music Library | 01:12:00",
          imageAsset: "assets/images/soft.png",
        ),
        FeatureItem(
          title: "Study Music",
          subtitle: "Music Library | 01:12:00",
          imageAsset: "assets/images/study.png",
        ),
        FeatureItem(
          title: "Classical Children's Relaxation",
          subtitle: "Music Library | 01:12:00",
          imageAsset: "assets/images/children.png",
        ),
      ],
    );
  }
}
