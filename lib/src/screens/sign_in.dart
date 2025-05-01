import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frqncy_app/src/screens/home.dart';
import 'package:frqncy_app/src/screens/sign_up.dart';
import 'package:frqncy_app/src/widget/form_widget.dart';
import 'package:gap/gap.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C0430),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //   icon: Icon(Icons.arrow_back, color: Colors.white),
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                // ),
                Gap(20),
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10),
                Text(
                  "Lorem ipsum dolor sit amet consecture commodo sapien arcu porta sit semper sed.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Gap(40),
                FormWidget(
                  hintText: 'Email Address',
                  inputType: TextInputType.emailAddress,
                ),
                Gap(16),
                FormWidget(
                  hintText: 'Password',
                  inputType: TextInputType.visiblePassword,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Gap(20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF6D349E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) => HomeScreen())),

                    child: Text("Sign In", style: TextStyle(fontSize: 18)),
                  ),
                ),
                Gap(30),
                Center(
                  child: Text(
                    "Or Continue With",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialButton(FontAwesomeIcons.facebook),
                    Gap(20),
                    socialButton(FontAwesomeIcons.google),
                    Gap(20),
                    socialButton(FontAwesomeIcons.apple),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed:
                        () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => SignUpScreen()),
                          (_) => false,
                        ),
                    child: Text(
                      "Don't have any Account here? Sign Up",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
      ),
      padding: EdgeInsets.all(12),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
