import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda_mart/views/splash_screen/controllers.onboarding/onboarding_controller.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/utils/Utils.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context);
    final dark = Utils.isDarkMode(context);
    return Positioned(
        bottom: kBottomNavigationBarHeight + 25,
        left: 20,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.doNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(activeDotColor: dark? Colors.white:Colors.black87,dotHeight: 6),
        )
    );
  }
}