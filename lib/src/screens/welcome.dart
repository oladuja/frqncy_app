import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frqncy_app/src/models/user.dart';
import 'package:frqncy_app/src/screens/home.dart';
import 'package:frqncy_app/src/screens/sign_in.dart';
import 'package:frqncy_app/src/screens/sign_up.dart';
import 'package:frqncy_app/src/services/auth_service.dart';
import 'package:frqncy_app/src/services/firestore_service.dart';
import 'package:frqncy_app/src/widget/sign_in_with.dart';
import 'package:toastification/toastification.dart';
import 'package:gap/gap.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B062B),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              children: [
                Gap(50.h),
                Text(
                  'Welcome To',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: Colors.white,
                  ),
                ),
                Gap(30.h),
                SvgPicture.asset(
                  'assets/svgs/logo.svg',
                  width: 165.w,
                  height: 125.h,
                ),
                Gap(15.h),
                Text(
                  'Sign up to begin your meditation\njourney',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 18.sp,
                  ),
                ),
                Gap(15.h),
                SignInWith(
                  value: 'Google',
                  imagePath: 'assets/images/flat-color-icons_google.png',
                  onTap: () async {
                    try {
                      final user = await AuthService().signInWithGoogle();
                      await FirestoreService().saveUser(
                        UserModel(
                          id: user!.user!.uid,
                          name: user.user?.displayName ?? '',
                          emailAddress: user.user!.email!,
                          imageUrl: user.user!.photoURL!,
                        ),
                      );
                      if (!context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (!context.mounted) return;
                      toastification.show(
                        context: context,
                        title: Text('Google sign-in failed'),
                        type: ToastificationType.error,
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      toastification.show(
                        context: context,
                        title: Text('Google sign-in failed'),
                        type: ToastificationType.error,
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    }
                  },
                ),
                SignInWith(
                  value: 'Apple',
                  imagePath: 'assets/images/mdi_apple.png',
                  onTap: () async {
                    try {
                      final user = await AuthService().signInWithApple();
                      await FirestoreService().saveUser(
                        UserModel(
                          id: user.user!.uid,
                          name: user.user!.displayName ?? '',
                          emailAddress: user.user!.email!,
                          imageUrl:
                              'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1380&t=st=1701420226~exp=1701420826~hmac=2284e7a4b1f4cc634d76e02dc665ad6f93fc816574f3a3a605581318745e20a0',
                        ),
                      );
                      if (!context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (!context.mounted) return;
                      toastification.show(
                        context: context,
                        title: Text('Apple sign-in failed'),
                        type: ToastificationType.error,
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      toastification.show(
                        context: context,
                        title: Text('Apple sign-in failed'),
                        type: ToastificationType.error,
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    }
                  },
                ),
                SignInWith(
                  value: 'Email',
                  imagePath: 'assets/images/mail.png',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                ),
                Gap(10.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account here?',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                    Gap(10.w),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SignInScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(50.h),
                Text(
                  'By Signing Up you will agree to our Terms &\nConditions and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12.sp,
                  ),
                ),
                Gap(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
