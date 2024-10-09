import 'package:flutter/material.dart';
import 'package:panda_mart/views/splash_screen/controllers.onboarding/onboarding_controller.dart';
import 'package:provider/provider.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context);
    return Positioned(
        top: 60,
        right: 20,
        child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Skip', style: TextStyle(fontSize: 18))));
  }
}
