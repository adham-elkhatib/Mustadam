import 'package:flutter/material.dart';
import 'package:mustadam/core/widgets/primary_button.dart';
import 'package:video_player/video_player.dart';

import '../../skeleton/skeleton_screen.dart';

class ThankYouScreen extends StatefulWidget {
  final String userName;

  const ThankYouScreen({super.key, required this.userName});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/thank_you.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const themeColor = Color(0xFF2F7575);
    const backgroundColor = Color(0xFFf2f3ee);

    return Scaffold(
      backgroundColor: backgroundColor,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: 'Thank you ',
                style: const TextStyle(fontSize: 22),
                children: [
                  TextSpan(
                    text: widget.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio:
                  _controller.value.isInitialized
                      ? _controller.value.aspectRatio
                      : 1,
              child:
                  _controller.value.isInitialized
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: VideoPlayer(_controller),
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 24),
            const Text(
              "You have successfully earned",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              "5 points",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: "Go Back",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SkeletonScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
