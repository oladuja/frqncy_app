import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormWidget(
                        controller: _firstNameController,
                        hintText: 'First Name',
                        inputType: TextInputType.name,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        isPassword: false,
                        obscureText: false,
                      ),
                      Gap(20),
                      FormWidget(
                        controller: _lastNameController,
                        hintText: 'Last Name',
                        inputType: TextInputType.name,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        isPassword: false,
                        obscureText: false,
                      ),
                      Gap(20),
                      FormWidget(
                        controller: _emailController,
                        hintText: 'Email Address',
                        inputType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!EmailValidator.validate(v)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        isPassword: false,
                        obscureText: false,
                      ),
                      Gap(20),
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
                      Gap(20),
                      FormWidget(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        inputType: TextInputType.name,
                        validator: (v) {
                          if (v == null || v.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (v != _passwordController.text) {
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
                            var user = await AuthService().registerWithEmail(
                              email: _emailController.value.text,
                              password: _passwordController.value.text,
                            );

                            await FirestoreService().saveUser(
                              UserModel(
                                id: user!.user!.uid,
                                firstName: _firstNameController.value.text,
                                lastName: _lastNameController.value.text,
                                emailAddress: _emailController.value.text,
                                imageUrl: '',
                              ),
                            );

                            if (!context.mounted) return;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => SupportJourneyScreen(),
                              ),
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
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },

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
