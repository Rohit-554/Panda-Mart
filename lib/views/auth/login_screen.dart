import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panda_mart/domain/models/user.dart';
import 'package:panda_mart/views/widgets/RoundedButton.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import '../viewModels/auth_viewmodel.dart';
import '../widgets/ErrorCard.dart';
import '../widgets/TwoFieldForm.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late UserEntity? user;
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView( // Add SingleChildScrollView here
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35, // Adjust the height dynamically
                      child: Image.asset(
                        'assets/images/panda_shopping.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Amazing Deals are Awaiting!",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TwoFieldFormLayout(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            formKey: formKey,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                user = await authViewModel.login(email, password, context);
                                if (user != null) {
                                  Navigator.pushReplacementNamed(context, '/home');
                                }
                              }
                            },
                            isLoading: authViewModel.isLoading,
                          ),
                          const SizedBox(height: 24),
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "Register",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                ),
                              ],
                            ),
                          ),
                          if (authViewModel.errorMessage != null)
                            ErrorCard(authViewModel: authViewModel),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}








