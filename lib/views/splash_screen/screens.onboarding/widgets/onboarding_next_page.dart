import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:panda_mart/views/splash_screen/controllers.onboarding/onboarding_controller.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/Utils.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final onBoardingController = Provider.of<OnBoardingController>(context);
    return Positioned(
      right: 24,
      bottom: kBottomNavigationBarHeight,
      child: ElevatedButton(
          onPressed: () {
            onBoardingController.nextPage(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
            Utils.isDarkMode(context) ? Color(0xff4b68ff): Colors.black  ,
            shape: const CircleBorder(),
          ),
          child: const Icon(
            Iconsax.arrow_right_3,
            color: Colors.white,
          )),
    );
  }
}