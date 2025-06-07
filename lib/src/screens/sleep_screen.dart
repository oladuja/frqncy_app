import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:frqncy_app/src/screens/details.dart';
import 'package:frqncy_app/src/widget/loading_widget.dart';

class SleepScreen extends StatelessWidget {
 const SleepScreen({super.key});

  Future<List<Content>> fetchItems() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('explore')
            .doc('sleep')
            .collection('sleep')
            .get();

    return snapshot.docs.map((doc) => Content.fromJson(doc.data())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Content>>(
      future: fetchItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidget();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return DetailsScreen(
          type: 2,
          barTitle: 'Sleep',
          title: "Sleep Well, Dream Big",
          description:
              "Sleep is a natural state of rest for the mind and body, essential for overall health and well-being. It helps to restore energy, improve mood, and enhance cognitive function. Quality sleep is crucial for physical and mental health, allowing the body to repair itself and the brain to process information.",
          imageAsset: "assets/images/sleep_big.png",
          contents: [],
        );
        }
        return DetailsScreen(
          type: 2,
          barTitle: 'Sleep',
          title: "Sleep Well, Dream Big",
          description:
              "Sleep is a natural state of rest for the mind and body, essential for overall health and well-being. It helps to restore energy, improve mood, and enhance cognitive function. Quality sleep is crucial for physical and mental health, allowing the body to repair itself and the brain to process information.",
          imageAsset: "assets/images/sleep_big.png",
          contents: snapshot.data!,
        );
      },
    );
  }
}
