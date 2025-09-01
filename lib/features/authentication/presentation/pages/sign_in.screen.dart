import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustadam/core/widgets/primary_button.dart';
import 'package:mustadam/features/authentication/presentation/pages/reset_password_screen.dart';
import 'package:mustadam/features/authentication/presentation/pages/sign_up.screen.dart';

import '../../../../Data/Model/User/user_role.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/models/auth.model.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/Services/Auth/src/Providers/firebase/methods/email_auth_method.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../skeleton/skeleton_screen.dart';

class SignInScreen extends StatefulWidget {
  final UserRole? selectedRole;

  const SignInScreen({super.key, this.selectedRole});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isStudent = widget.selectedRole == UserRole.student;

    return Scaffold(
      backgroundColor: Colors.teal[700],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.image, size: 40, color: Colors.teal),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Sign in to continue.",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 32),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.teal[50],
                          labelText: " Email",

                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.teal[50],
                          labelText: "Password",
                          hintText: '********',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              EmailAuthMethod emailAuthMethod = EmailAuthMethod(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                              );

                              AuthService authService = AuthService(
                                authProvider: FirebaseAuthProvider(
                                  firebaseAuth: FirebaseAuth.instance,
                                ),
                              );

                              AuthModel? authModel = await authService.signIn(
                                emailAuthMethod,
                              );

                              if (authModel != null) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (_) => const SkeletonScreen(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                SnackbarHelper.showError(
                                  context,
                                  title: "Failed to sign in",
                                );
                              }
                            }
                          },
                          title: "Log in",
                        ),
                      ),

                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const ResetPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text("Forgot Password"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => SignUpScreen(
                                          selectedRole: widget.selectedRole!,
                                        ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Don’t have an account? Signup",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
