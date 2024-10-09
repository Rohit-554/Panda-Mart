import 'package:flutter/material.dart';
import 'package:panda_mart/views/widgets/RoundedButton.dart';
import 'package:panda_mart/views/widgets/TwoFieldForm.dart';

class ThreeFieldFormLayout extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;
  final bool isLoading;

  const ThreeFieldFormLayout({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          EmailField(emailController: emailController),
          const SizedBox(height: 16),
          PasswordField(passwordController: passwordController),
          const SizedBox(height: 16),
          PasswordField(passwordController: confirmPasswordController,hintText: "Confirm Password",),
          const SizedBox(height: 16),
          RoundedButton(textEditingController: emailController, onPressed: onPressed, text: "Sign Up", isLoading: isLoading,)
        ],
      ),
    );
  }
}
