import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackDescriptionPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const TrackDescriptionPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B062B),
      body: Stack(
        children: [
          Hero(
            tag: item,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, color: Colors.black),

                      const SizedBox(width: 16),
                      const Icon(Icons.share, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                color: Color(0xFF1B062B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        size: 20,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Relaxing Sound',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '5:00 mins',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Start your day with clarity and positivity. This guided meditation helps you set intentions, cultivate gratitude, and embrace the day with a calm, focused mind. ✨',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6D349E),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Listen Now',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
