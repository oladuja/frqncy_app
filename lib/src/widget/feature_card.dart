import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/details.dart';



class FeatureCardTwo extends StatelessWidget {
  final FeatureItem feature;

  const FeatureCardTwo({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), 
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Left: Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  feature.subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right: Icon/Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              feature.imageAsset,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
