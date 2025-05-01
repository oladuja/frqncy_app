import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/continue.dart';
import 'package:frqncy_app/src/screens/sign_in.dart';
import 'package:frqncy_app/src/widget/form_widget.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                  "Sign Up",
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
                Row(
                  children: [
                    Expanded(
                      child: FormWidget(
                        hintText: 'First Name',
                        inputType: TextInputType.name,
                      ),
                    ),
                    Gap(12),
                    Expanded(
                      child: FormWidget(
                        hintText: 'Last Name',
                        inputType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
                Gap(20),
                FormWidget(
                  hintText: 'Email Address',
                  inputType: TextInputType.emailAddress,
                ),
                Gap(20),
                FormWidget(
                  hintText: 'Password',
                  inputType: TextInputType.visiblePassword,
                ),
                Gap(20),
                FormWidget(
                  hintText: 'Confirm Password',
                  inputType: TextInputType.name,
                ),
                Gap(20),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                      children: [
                        TextSpan(text: "by Signing Up you will agree to our "),
                        TextSpan(
                          text: "Terms & Conditions",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(30),
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
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) =>SupportJourneyScreen() )),
                    child: Text(
                      "Create Account",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Gap(15),
                Center(
                  child: TextButton(
                    onPressed:
                        () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => SignInScreen()),
                          (_) => false,
                        ),
                    child: Text(
                      "Already have an account here? Sign In",
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

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white54),
      filled: true,
      fillColor: Color(0xFF2E1055),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    );
  }
}
