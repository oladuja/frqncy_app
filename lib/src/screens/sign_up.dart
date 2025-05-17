import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frqncy_app/src/models/user.dart';
import 'package:frqncy_app/src/screens/continue.dart';
import 'package:frqncy_app/src/screens/sign_in.dart';
import 'package:frqncy_app/src/services/auth_service.dart';
import 'package:frqncy_app/src/services/firestore_service.dart';
import 'package:frqncy_app/src/widget/form_widget.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    setState(() => _isLoading = true);

    if (_formKey.currentState?.validate() != true) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final userCredential = await AuthService().registerWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await FirestoreService().saveUser(
        UserModel(
          id: userCredential!.user!.uid,
          name: _nameController.text.trim(),
          emailAddress: _emailController.text.trim(),
          imageUrl: 'https://www.transparentpng.com/thumb/user/gray-user-profile-icon-png-fP8Q1P.png',
        ),
      );

      if (!mounted) return;

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => SupportJourneyScreen()));
    } on FirebaseAuthException catch (e) {
      toastification.show(
        context: context,
        title: Text('Authentication Error: ${e.message}', softWrap: true),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } catch (e) {
      toastification.show(
        context: context,
        title: Text('Error: $e', softWrap: true),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 5),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
                  "Sign Up",
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
                        controller: _nameController,
                        hintText: 'Name',
                        inputType: TextInputType.name,
                        validator:
                            (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Please enter your first name'
                                    : null,
                        isPassword: false,
                        obscureText: false,
                      ),
                      Gap(20.h),
                      FormWidget(
                        controller: _emailController,
                        hintText: 'Email Address',
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        isPassword: false,
                        obscureText: false,
                      ),
                      Gap(20.h),
                      FormWidget(
                        controller: _passwordController,
                        hintText: 'Password',
                        inputType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Password must contain at least one uppercase letter';
                          }
                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Password must contain at least one lowercase letter';
                          }
                          if (!RegExp(r'\d').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }
                          if (!RegExp(r'[!@#\$&*~_%^()-]').hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                        isPassword: true,
                        obscureText: true,
                      ),
                      Gap(20.h),
                      FormWidget(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        inputType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        isPassword: true,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                Gap(20.h),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      children: const [
                        TextSpan(text: "By signing up, you agree to our "),
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
                Gap(30.h),
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
                          backgroundColor: const Color(0xFF6D349E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        onPressed: _handleSignUp,
                        child: Text(
                          "Create Account",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),
                    ),
                Gap(15.h),
                Center(
                  child: TextButton(
                    onPressed:
                        () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const SignInScreen(),
                          ),
                          (_) => false,
                        ),
                    child: Text(
                      "Already have an account? Sign In",
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
}
