import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frqncy_app/src/widget/feature_card.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String barTitle;
  final String description;
  final String imageAsset;
  final List features;
  final int type;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.features,
    required this.barTitle,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF1B062B),
        body: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  Image.asset(
                    imageAsset,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Text(
                        barTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "FEATURED",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(Icons.volume_up_outlined),
                        Gap(5),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6D349E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(FontAwesomeIcons.lock, color: Colors.white),
                            Gap(10),
                            Text('Play'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  // labelPadding: EdgeInsets.zero,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color(0xFF6D349E),
                      width: 2.5,
                    ),
                    insets: EdgeInsets.only(right: 30),
                  ),
                  isScrollable: true,
                  tabs: [
                    Tab(child: Text('Recents', style: TextStyle(fontSize: 22))),
                    Tab(
                      child: Text('Features', style: TextStyle(fontSize: 22)),
                    ),
                  ],

                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  dividerHeight: 0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: TabBarView(
                  children: [
                    Center(
                      child: Text(
                        'Recents Coming Soon',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        final feature = features[index];
                        return (type == 2)
                            ? FeatureCardTwo(feature: feature)
                            : FeatureCard(feature: feature);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem {
  final String title;
  final String subtitle;
  final String imageAsset;

  FeatureItem({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });
}

class FeatureCard extends StatelessWidget {
  final FeatureItem feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            feature.imageAsset,
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          const Gap(16),
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
                const Gap(4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      Icons.volume_up_outlined,
                      color: Colors.white70,
                      size: 16,
                    ),
                    Gap(5),
                    Text(
                      feature.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.lock, color: Colors.white30, size: 20),
        ],
      ),
    );
  }
}
