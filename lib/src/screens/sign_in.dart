import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frqncy_app/src/screens/home.dart';
import 'package:frqncy_app/src/screens/sign_up.dart';
import 'package:frqncy_app/src/services/auth_service.dart';
import 'package:frqncy_app/src/widget/form_widget.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormWidget(
                        controller: _emailController,
                        hintText: 'Email Address',
                        inputType: TextInputType.emailAddress,
                        isPassword: false,
                        obscureText: false,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!EmailValidator.validate(v)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      Gap(16),
                      FormWidget(
                        controller: _passwordController,
                        hintText: 'Password',
                        inputType: TextInputType.visiblePassword,
                        obscureText: true,
                        isPassword: true,
                        validator: (v) {
                          if (v == null || v.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
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
                _isLoading
                    ? Center(
                      child: LoadingAnimationWidget.progressiveDots(
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                    : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFF6D349E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (_formKey.currentState?.validate() != true) {
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }

                          try {
                            await AuthService().signInWithEmail(
                              email: _emailController.value.text,
                              password: _passwordController.value.text,
                            );
                            if (!context.mounted) return;

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => HomeScreen()),
                            );
                          } on FirebaseAuthException catch (e) {
                            toastification.show(
                              context: context,
                              title: Text(
                                'Authentication Error: ${e.message}',
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
                                'Error: $e',
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              type: ToastificationType.error,
                              autoCloseDuration: const Duration(seconds: 5),
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },

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
                    // socialButton(FontAwesomeIcons.facebook),
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
