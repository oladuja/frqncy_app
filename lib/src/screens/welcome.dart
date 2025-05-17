import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Color(0XFF1B062B),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Gap(50),
              Text(
                'Welcome To',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Gap(30),
              SvgPicture.asset('assets/svgs/logo.svg', width: 165, height: 125),
              Gap(15),
              Text(
                'Sign up to begin your meditation\njourney',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 18,
                ),
              ),
              Gap(15),
              SignInWith(
                value: 'Google',
                imagePath: 'assets/images/flat-color-icons_google.png',
                onTap: () async {
                  try {
                    final user = await AuthService().signInWithGoogle();
                    await FirestoreService().saveUser(
                      UserModel(
                        id: user!.user!.uid,
                        name: user.user!.displayName!,
                        emailAddress: user.user!.email!,
                        imageUrl: user.user!.photoURL!,
                      ),
                    );
                    if (!context.mounted) return;
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => HomeScreen()));
                  } on FirebaseAuthException catch (e) {
                    if (!context.mounted) return;
                    toastification.show(
                      context: context,
                      title: Text(
                        'Google sign-in failed: $e',
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      type: ToastificationType.error,
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    toastification.show(
                      context: context,
                      title: Text(
                        'Google sign-in failed: $e',
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      type: ToastificationType.error,
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  }
                },
              ),
              // SignInWith(
              //   value: 'Facebook',
              //   imagePath: 'assets/images/logos_facebook.png',

              // ),
              SignInWith(
                value: 'Apple',
                imagePath: 'assets/images/mdi_apple.png',
                onTap: () async {
                  try {
                    final user = await AuthService().signInWithApple();
                    await FirestoreService().saveUser(
                      UserModel(
                        id: user!.user!.uid,
                        name: user.user!.displayName!,
                        emailAddress: user.user!.email!,
                        imageUrl: user.user!.photoURL!,
                      ),
                    );
                    if (!context.mounted) return;
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => HomeScreen()));
                  } on FirebaseAuthException catch (e) {
                    if (!context.mounted) return;
                    toastification.show(
                      context: context,
                      title: Text(
                        'Apple sign-in failed: $e',
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      type: ToastificationType.error,
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    toastification.show(
                      context: context,
                      title: Text(
                        'Apple sign-in failed: $e',
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      type: ToastificationType.error,
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  }
                },
              ),
              SignInWith(
                value: 'Email',
                imagePath: 'assets/images/mail.png',
                onTap:
                    () => Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => SignUpScreen())),
              ),
              Gap(10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Already have an account here?',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  Gap(10),
                  TextButton(
                    onPressed:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SignInScreen()),
                        ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Gap(50),
              Text(
                'by Signing Up you will agree to our Terms & \n Conditions and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
