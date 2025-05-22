import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loaders {
  static void errorSnackBar({
    required String title,
    String message = 'Bir hata oluştu!',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ProjectColors.redColor,
      colorText: ProjectColors.whiteColor,
      duration: duration,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1000),
        showCloseIcon: true,
        backgroundColor: ProjectColors.grayColor,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: ProjectSizes.small),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            message,
            style: Theme.of(Get.context!)
                .textTheme
                .titleLarge!
                .apply(color: ProjectColors.whiteColor),
          ),
        )));
  }

  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: ProjectColors.whiteColor,
      backgroundColor: ProjectColors.green2Color, // Başarı için yeşil renk
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  static void warningSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: ProjectColors.whiteColor,
      backgroundColor: ProjectColors.orangeColor, // Uyarı için turuncu renk
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }
}
