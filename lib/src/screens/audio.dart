import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frqncy_app/src/models/content.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class PlayerScreen extends StatefulWidget {
  final Content content;
  const PlayerScreen({super.key, required this.content});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayer _player = AudioPlayer();
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool isPlaying = false;
  late final List<Color> _gradientColors;

  @override
  void initState() {
    super.initState();
    _generateRandomGradient();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(widget.content.musicUrl),
          tag: MediaItem(
            id: widget.content.musicUrl,
            album: widget.content.subtitle,
            title: widget.content.title,
            artUri: Uri.parse(widget.content.imageUrl),
          ),
        ),
      );
    } catch (e) {
      debugPrint("Audio setup error: $e");
    }

    _player.positionStream.listen((pos) {
      setState(() => _position = pos);
    });

    _player.durationStream.listen((dur) {
      if (dur != null) setState(() => _duration = dur);
    });

    _player.playingStream.listen((playing) {
      setState(() => isPlaying = playing);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _togglePlayback() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  void _seek(Duration offset) {
    final newPosition = _position + offset;
    final clampedPosition =
        newPosition < Duration.zero
            ? Duration.zero
            : (newPosition > _duration ? _duration : newPosition);
    _player.seek(clampedPosition);
  }

  void _generateRandomGradient() {
    final random = Random();
    _gradientColors = [
      Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      ),
      Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                widget.content.title,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              Gap(10.h),
              Text(
                widget.content.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay_10, color: Colors.white),
                    onPressed: () => _seek(const Duration(seconds: -10)),
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      size: 64.sp,
                      color: Colors.white,
                    ),
                    onPressed: _togglePlayback,
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward_10, color: Colors.white),
                    onPressed: () => _seek(const Duration(seconds: 10)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Text(
                      _formatTime(_position),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const Spacer(),
                    Text(
                      _formatTime(_duration),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Slider(
                activeColor: Colors.white,
                inactiveColor: Colors.white24,
                min: 0,
                max: _duration.inSeconds.toDouble().clamp(1, double.infinity),
                value:
                    _position.inSeconds
                        .clamp(0, _duration.inSeconds)
                        .toDouble(),
                onChanged:
                    (value) => _player.seek(Duration(seconds: value.toInt())),
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
