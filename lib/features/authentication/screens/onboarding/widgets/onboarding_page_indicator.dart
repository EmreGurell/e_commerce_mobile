import 'package:tarhanaciyasarmobil/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final isDark = HelperFuctions.isDarkMode(context);
    return Positioned(
      bottom: DeviceUtility.getBottomNavigationBarHeight() + 25,
      right: 0,
      left: 0,
      child: Align(
        alignment: Alignment.center,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          count: 4,
          onDotClicked: controller.dotNavigationClick,
          effect: ExpandingDotsEffect(
              activeDotColor:
                  isDark ? ProjectColors.blueColor : ProjectColors.financeColor,
              dotHeight: 4),
        ),
      ),
    );
  }
}
