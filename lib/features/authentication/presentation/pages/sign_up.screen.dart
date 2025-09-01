import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustadam/features/authentication/presentation/pages/sign_in.screen.dart';

import '../../../../Data/Model/User/college_enum.dart';
import '../../../../Data/Model/User/user.model.dart';
import '../../../../Data/Model/User/user_role.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../skeleton/skeleton_screen.dart';

class SignUpScreen extends StatefulWidget {
  final UserRole selectedRole;

  const SignUpScreen({super.key, required this.selectedRole});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController staffNameController = TextEditingController();
  final TextEditingController staffNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  College? selectedCollege;

  bool get isStudent => widget.selectedRole == UserRole.student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(Icons.person_add, size: 40, color: Colors.teal),
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
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isStudent
                            ? "Create a student account"
                            : "Create a staff account",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),

                      if (isStudent)
                        _buildLabeledField(
                          label: "Student ID",
                          controller: studentIdController,
                          hintText: "Student ID",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Student ID is required";
                            }
                            if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                              return "Enter a valid 9-digit ID";
                            }
                            return null;
                          },
                        )
                      else ...[
                        _buildLabeledField(
                          label: "Staff Name",
                          controller: staffNameController,
                          hintText: "Name",
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? "Staff name is required"
                                      : null,
                        ),
                        const SizedBox(height: 16),
                        _buildLabeledField(
                          label: "Staff ID",
                          controller: staffNumberController,
                          hintText: "Staff ID",
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? "Staff number is required"
                                      : null,
                        ),
                      ],

                      const SizedBox(height: 16),
                      _buildLabeledField(
                        label: "Full Name",
                        controller: nameController,
                        hintText: "Your Name",
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Name is required"
                                    : null,
                      ),

                      const SizedBox(height: 16),
                      _buildLabeledField(
                        label: "Email",
                        controller: emailController,
                        hintText: "example@domain.com",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          if (!RegExp(pattern).hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      _buildCollegeDropdown(),

                      const SizedBox(height: 16),
                      _buildLabeledField(
                        label: "Password",
                        controller: passwordController,
                        hintText: "********",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _handleSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 12,
                            ),
                          ),
                          child: const Text("Create Account"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignInScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollegeDropdown() {
    return DropdownButtonFormField<College>(
      decoration: InputDecoration(
        filled: true,

        fillColor: Colors.teal[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      value: selectedCollege,
      hint: const Text("Select College"),
      items:
          College.values
              .map(
                (college) => DropdownMenuItem(
                  value: college,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      college.label,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              )
              .toList(),
      validator: (value) => value == null ? "Please select your college" : null,
      onChanged: (value) {
        setState(() {
          selectedCollege = value;
        });
      },
    );
  }

  Widget _buildLabeledField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase()),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.teal[50],
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    );

    final authModel = await authService.signUp(
      emailController.text.trim(),
      passwordController.text,
    );

    if (authModel != null && selectedCollege != null) {
      final user = UserModel(
        id: authModel.uid,
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        userRole: widget.selectedRole,
        college: selectedCollege!,
      );

      await AppUserRepo().createSingle(user, itemId: authModel.uid);

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (_) => const SkeletonScreen()),
        (route) => false,
      );
    } else {
      SnackbarHelper.showError(context, title: 'Failed to sign up');
    }
  }
}
