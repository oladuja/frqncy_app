import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignInWith extends StatelessWidget {
  final String value;
  final String imagePath;
  final void Function() onTap;

  const SignInWith({
    super.key,
    required this.value,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),

          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 34, height: 34),
            Gap(12),
            Text(
              'Continue With $value',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
