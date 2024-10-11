import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../domain/models/user.dart';
import '../viewModels/auth_viewmodel.dart';
import '../widgets/ErrorCard.dart';
import '../widgets/ThreeFieldForm.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3, // Adjust as needed
                      child: Image.asset(
                        'assets/images/panda_shopping.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Join Us for Amazing Deals!",
                            style: GoogleFonts.quicksand(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ThreeFieldFormLayout(
                            emailController: _emailController,
                            passwordController: _passwordController,
                            confirmPasswordController: _confirmPasswordController,
                            formKey: formKey,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                String confirmPassword = _confirmPasswordController.text;
                                if (password == confirmPassword) {
                                  user = await authViewModel.register(email, password, context);
                                  if (user != null) {
                                    Navigator.pushReplacementNamed(context, '/home');
                                  }
                                }else{
                                  authViewModel.setErrorMessage("Passwords do not match");
                                }
                              }
                            },
                            isLoading: authViewModel.isLoading,
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: "Log in",
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(context, '/login');
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

