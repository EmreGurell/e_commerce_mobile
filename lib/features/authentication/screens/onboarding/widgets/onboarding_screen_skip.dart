import 'package:tarhanaciyasarmobil/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

class OnboardingScreenSkip extends StatelessWidget {
  const OnboardingScreenSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: DeviceUtility.getAppBarHeight(),
        right: ProjectPadding.pagePadding.value(),
        child: TextButton(
          onPressed: () => OnboardingController.instance.skipPage(),
          child: Text(
            'Atla',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ));
  }
}
