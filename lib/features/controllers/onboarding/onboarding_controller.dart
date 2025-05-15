import 'package:tarhanaciyasarmobil/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  //Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  //Update Current Index when Page Scroll
  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  //Jump to the spesific dot selected page.
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  //Update Current Index & jump to next page

  void nextPage() {
    print(currentPageIndex.value);
    if (currentPageIndex.value == 3) {
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.to(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.animateToPage(
        page,
        duration:
            const Duration(milliseconds: 300), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the animation curve if desired
      );
    }
  }

  //Update Current Index & jump to the last page
  void skipPage() {
    currentPageIndex.value = 3;
    pageController.jumpToPage(3);
  }
}
