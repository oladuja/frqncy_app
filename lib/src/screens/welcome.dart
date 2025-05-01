import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frqncy_app/src/screens/sign_in.dart';
import 'package:frqncy_app/src/widget/sign_in_with.dart';
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
              ),
              SignInWith(
                value: 'Facebook',
                imagePath: 'assets/images/logos_facebook.png',
              ),
              SignInWith(
                value: 'Apple',
                imagePath: 'assets/images/mdi_apple.png',
              ),
              SignInWith(value: 'Email', imagePath: 'assets/images/mail.png'),
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
