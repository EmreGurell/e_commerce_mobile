import 'package:tarhanaciyasarmobil/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/onboarding/widgets/onboarding_next_btn.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/onboarding/widgets/onboarding_page_indicator.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/onboarding/widgets/onboarding_screen.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/onboarding/widgets/onboarding_screen_skip.dart';
import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnboardingPage(
                title: ProjectTexts.onboardingTitle1,
                subtitle: ProjectTexts.onboardingSubtitle1,
                image: ImagePaths.onboardingImage1,
              ),
              OnboardingPage(
                title: ProjectTexts.onboardingTitle2,
                subtitle: ProjectTexts.onboardingSubtitle2,
                image: ImagePaths.onboardingImage2,
              ),
              OnboardingPage(
                title: ProjectTexts.onboardingTitle3,
                subtitle: ProjectTexts.onboardingSubtitle3,
                image: ImagePaths.onboardingImage3,
              ),
              OnboardingPage(
                title: ProjectTexts.onboardingTitle4,
                subtitle: ProjectTexts.onboardingSubtitle4,
                image: ImagePaths.onboardingImage4,
              ),
            ],
          ),
          const OnboardingScreenSkip(),
          const OnboardingPageIndicator(),
          const OnboardingNextBtn()
        ],
      ),
    );
  }
}
