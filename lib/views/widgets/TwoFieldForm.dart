import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:panda_mart/core/utils/Utils.dart';

import 'RoundedButton.dart';

class TwoFieldFormLayout extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;
  final isLoading;

  const TwoFieldFormLayout({super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        children: [
          EmailField(emailController: emailController),
          const SizedBox(height: 20),
          PasswordField(passwordController: passwordController),
          const SizedBox(height: 20),
          RoundedButton(textEditingController: emailController, onPressed: onPressed, text: "Login", isLoading: isLoading,)
        ],
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailField({Key? key, required this.emailController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email Address';
        } else if (!Utils.isValidEmail(value)) {
          return 'Please enter a valid Email Address';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black87,
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final hintText;

  const PasswordField({Key? key, required this.passwordController, this.hintText= "Password"}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _obscureText,
      validator: (value) {
        if(value!.isEmpty && widget.hintText=="Confirm Password"){
          return 'Please confirm your password ';
        } else if (value.isEmpty) {
          return 'Please enter your ${widget.hintText}';
        } else if (!Utils.isValidPassword(value)) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Iconsax.eye_slash : Iconsax.eye4,
          ),
          onPressed: _toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


