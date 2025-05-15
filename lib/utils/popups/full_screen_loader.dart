import 'package:tarhanaciyasarmobil/common/widgets/loaders/animation_loaders.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: HelperFuctions.isDarkMode(Get.context!)
                  ? ProjectColors.neutralBlackColor
                  : ProjectColors.whiteColor,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250),
                  AnimationLoaderWidget(
                    text: text,
                    animation: animation,
                    showAction: true,
                  )
                ],
              ),
            )));
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
