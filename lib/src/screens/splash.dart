import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frqncy_app/src/screens/home.dart';
import 'package:frqncy_app/src/screens/welcome.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: const Duration(seconds: 5),
      nextScreen: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.progressiveDots(
                  color: Colors.white,
                  size: 50.sp,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return Welcome();
        },
      ),
      childWidget: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/images/splash.jpg', fit: BoxFit.fitWidth)
            // Animate the image
            .animate()
            .fadeIn(duration: 2.seconds)
            .scale(duration: 2.seconds, curve: Curves.easeOutBack),
      ),
    );
  }
}
