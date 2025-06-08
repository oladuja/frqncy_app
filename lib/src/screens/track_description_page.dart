import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:frqncy_app/src/screens/audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class TrackDescriptionPage extends StatefulWidget {
  final Content content;

  const TrackDescriptionPage({super.key, required this.content});

  @override
  State<TrackDescriptionPage> createState() => _TrackDescriptionPageState();
}

class _TrackDescriptionPageState extends State<TrackDescriptionPage> {
  String duration = '--:-- mins';

 Future<String> getAudioDuration(String url) async {
  final player = AudioPlayer();
  try {
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: widget.content.id,
          album: 'Frqncy',
          title: widget.content.title,
          artist: 'Frqncy',

          artUri: Uri.parse(widget.content.imageUrl),
        ),
      ),
    );
    final duration = player.duration;
    if (duration == null) return '0:00 mins';

    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')} mins';
  } catch (e) {
    return '0:00 mins';
  } finally {
    await player.dispose();
  }
}


  void checkDuration() async {
    String result = await getAudioDuration(widget.content.musicUrl);
    setState(() {
      duration = result;
    });
  }

  @override
  void initState() {
    super.initState();
    checkDuration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B062B),
      body: Stack(
        children: [
          Hero(
            tag: widget.content.id,
            child: Container(
              height: 0.45.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.content.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  // Row(
                  //   children: [
                  //     const Icon(Icons.favorite_border, color: Colors.black),
                  //     Gap(16.w),
                  //     const Icon(Icons.share, color: Colors.black),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 0.65.sh,
              decoration: BoxDecoration(
                color: Color(0xFF1B062B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.content.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(24.h),

                  Row(
                    children: [
                      Icon(
                        Icons.music_note,
                        size: 20.sp,
                        color: Colors.white70,
                      ),
                      Gap(6.w),
                      Text(
                        widget.content.subtitle,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.access_time, size: 20.sp, color: Colors.white),
                      Gap(6.w),
                      Text(
                        duration,
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gap(24.h),
                  Text(
                    widget.content.description,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      PlayerScreen(content: widget.content),
                            ),
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6D349E),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Listen Now',
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
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
