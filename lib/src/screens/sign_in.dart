import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/home.dart';
import 'package:frqncy_app/src/screens/sign_up.dart';
import 'package:frqncy_app/src/services/auth_service.dart';
import 'package:frqncy_app/src/widget/form_widget.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      backgroundColor: const Color(0xFF1C0430),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20.h),
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10.h),
                Text(
                  "Lorem ipsum dolor sit amet consecture commodo sapien arcu porta sit semper sed.",
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                ),
                Gap(40.h),
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
                      Gap(16.h),
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
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ),
                ),
                Gap(20.h),
                _isLoading
                    ? Center(
                      child: LoadingAnimationWidget.progressiveDots(
                        color: Colors.white,
                        size: 50.w,
                      ),
                    )
                    : SizedBox(
                      width: double.infinity,
                      height: 60.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF6D349E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
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
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),
                    ),
                Gap(30.h),
                // Center(
                //   child: Text(
                //     "Or Continue With",
                //     style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                //   ),
                // ),
                // Gap(20.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // socialButton(FontAwesomeIcons.facebook),
                //     Gap(20.w),
                //     socialButton(FontAwesomeIcons.google),
                //     Gap(20.w),
                //     socialButton(FontAwesomeIcons.apple),
                //   ],
                // ),
                Center(
                  child: TextButton(
                    onPressed:
                        () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                          (_) => false,
                        ),
                    child: Text(
                      "Don't have any Account here? Sign Up",
                      style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                    ),
                  ),
                ),
                Gap(20.h),
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
      padding: EdgeInsets.all(12.w),
      child: Icon(icon, color: Colors.white, size: 24.sp),
    );
  }
}
