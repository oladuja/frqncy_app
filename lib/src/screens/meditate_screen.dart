import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:frqncy_app/src/screens/details.dart';
import 'package:frqncy_app/src/widget/loading_widget.dart';

class MeditateScreen extends StatelessWidget {
  const MeditateScreen({super.key});

  Future<List<Content>> fetchItems() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('explore')
            .doc('medidate')
            .collection('medidate')
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
            barTitle: 'Medidate',
            title: "Meditation",
            description:
                "Meditation is a practice that involves focusing the mind to achieve a mentally clear and emotionally calm state. It can help reduce stress, improve concentration, and promote overall well-being.",
            imageAsset: "assets/images/meditate_big.png",
            contents: [],
          );
        }
        return DetailsScreen(
          type: 0,
          barTitle: 'Medidate',
          title: "Meditation",
          description:
              "Meditation is a practice that involves focusing the mind to achieve a mentally clear and emotionally calm state. It can help reduce stress, improve concentration, and promote overall well-being.",
          imageAsset: "assets/images/meditate_big.png",
          contents: snapshot.data!,
        );
      },
    );
  }
}
