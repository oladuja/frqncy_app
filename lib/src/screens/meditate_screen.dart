import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/details.dart';


class MeditateScreen extends StatelessWidget {
  const MeditateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsScreen(
      type: 0,
      barTitle: 'Medidate',
      title: "Beginners Meditation",
      description: "Meditation | 20 Mins",
      imageAsset: "assets/images/meditate_big.png",
      features: [
        FeatureItem(
          title: "Learn Basics Of Meditations",
          subtitle: "Meditation | 20 Mins",
          imageAsset: "assets/images/learn.png",
        ),
        FeatureItem(
          title: "Breathe",
          subtitle: "Meditation | 20 Mins",
          imageAsset: "assets/images/breathe.png",
        ),
        FeatureItem(
          title: "Letting Go Of Stress",
          subtitle: "Course | 10-20 Mins",
          imageAsset: "assets/images/stress.png",
        ),
      ],
    );
  }
}
