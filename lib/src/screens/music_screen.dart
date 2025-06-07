import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:frqncy_app/src/screens/details.dart';
import 'package:frqncy_app/src/widget/loading_widget.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  Future<List<Content>> fetchItems() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('explore')
            .doc('music')
            .collection('music')
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
            type: 0,
            barTitle: 'Music',
            title: "Makes a Better You!",
            description:
                "Music works by stimulating the brain's reward system, releasing dopamine, and enhancing mood. It can reduce stress, improve cognitive function, and promote relaxation. Listening to music can also evoke emotions and memories, making it a powerful tool for emotional expression and connection.",
            imageAsset: "assets/images/music_big.png",
            contents: [],
          );
        }
        return DetailsScreen(
          type: 0,
          barTitle: 'Music',
          title: "Makes a Better You!",
          description:
              "Music works by stimulating the brain's reward system, releasing dopamine, and enhancing mood. It can reduce stress, improve cognitive function, and promote relaxation. Listening to music can also evoke emotions and memories, making it a powerful tool for emotional expression and connection.",
          imageAsset: "assets/images/music_big.png",
          contents: snapshot.data!,
        );
      },
    );
  }
}
