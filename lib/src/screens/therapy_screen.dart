import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/details.dart';

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsScreen(
      type: 2,
      barTitle: 'Therapy',
      title: "Makes a Better You!",
      description: "Therapy | 20 Mins",
      imageAsset: "assets/images/therapy_big.png",
      features: [
        FeatureItem(
          title: "Overcoming Anxiety & Panic",
          subtitle: "How to overcome anxiety",
          imageAsset: "assets/images/anxiety.png",
        ),
        FeatureItem(
          title: "Self-Worth & Confidence Building",
          subtitle: "Boost your confidence",
          imageAsset: "assets/images/selfworth_2.png",
        ),
        FeatureItem(
          title: "Grief & Loss Recovery",
          subtitle: "Recover from grief",
          imageAsset: "assets/images/grief.png",
        ),
        FeatureItem(
          title: "Letting Go & Moving Forward",
          subtitle: "Recover from grief",
          imageAsset: "assets/images/moving.png",
        ),
      ],
    );
  }
}
