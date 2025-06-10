import 'package:tarhanaciyasarmobil/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingNextBtn extends StatelessWidget {
  const OnboardingNextBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFuctions.isDarkMode(context);
    return Positioned(
        bottom: DeviceUtility.getBottomNavigationBarHeight(),
        right: ProjectPadding.pagePadding.value(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor:
                  isDark ? ProjectColors.greenColor : ProjectColors.greenColor,
            ),
            onPressed: () => OnboardingController.instance.nextPage(),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}
