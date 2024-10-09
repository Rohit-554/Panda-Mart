import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:panda_mart/core/utils/Utils.dart';
import 'package:panda_mart/views/splash_screen/controllers.onboarding/onboarding_controller.dart';
import 'package:panda_mart/views/splash_screen/screens.onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:panda_mart/views/splash_screen/screens.onboarding/widgets/onboarding_next_page.dart';
import 'package:panda_mart/views/splash_screen/screens.onboarding/widgets/onboarding_page.dart';
import 'package:panda_mart/views/splash_screen/screens.onboarding/widgets/onboarding_skip.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkIfUserExist(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: [
            OnBoardingPage(
                width: width,
                height: height,
                image: 'assets/lotie/working_panda_rm.json',
                title: 'Panda Mart',
                subTitle:
                    'Welcome to a World of Limitless choices - Your perfect product awaits'),
            OnBoardingPage(
                width: width,
                height: height,
                image: 'assets/lotie/sleeping_panda.json',
                title: 'Panda Mart',
                subTitle:
                    'Welcome to a World of Limitless choices - Your perfect product awaits'),
            OnBoardingPage(
                width: width,
                height: height,
                image: 'assets/lotie/savings_graph.json',
                title: 'Panda Mart',
                subTitle:
                    'Welcome to a World of Limitless choices - Your perfect product awaits'),
          ],
        ),
        const OnBoardingSkip(),
        const OnBoardingDotNavigation(),
        const OnBoardingNextButton()
      ],
    ));
  }
}

void checkIfUserExist(BuildContext context){
  final user = FirebaseAuth.instance.currentUser;
  if(user != null){
    Navigator.pushReplacementNamed(context, '/home');
  }
}

