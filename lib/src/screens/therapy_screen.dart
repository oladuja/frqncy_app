import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:frqncy_app/src/screens/details.dart';
import 'package:frqncy_app/src/widget/loading_widget.dart';

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  Future<List<Content>> fetchItems() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('explore')
            .doc('therapy')
            .collection('therapy')
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
            barTitle: 'Therapy',
            title: "Makes a Better You!",
            description:
                "Therapy is a process of healing and self-discovery that involves working with a trained professional to address emotional, psychological, or behavioral issues. It provides a safe space to explore thoughts and feelings, develop coping strategies, and improve overall mental health and well-being.",
            imageAsset: "assets/images/therapy_big.png",
            contents: [],
          );
        }
        return DetailsScreen(
          type: 2,
          barTitle: 'Therapy',
          title: "Makes a Better You!",
          description:
              "Therapy is a process of healing and self-discovery that involves working with a trained professional to address emotional, psychological, or behavioral issues. It provides a safe space to explore thoughts and feelings, develop coping strategies, and improve overall mental health and well-being.",
          imageAsset: "assets/images/therapy_big.png",
          contents: snapshot.data!,
        );
      },
    );
  }
}
