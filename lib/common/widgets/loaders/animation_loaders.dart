import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    required this.showAction,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: DeviceUtility.getScreenWidth(context) * .8),
          const SizedBox(height: ProjectSizes.pagePadding),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: ProjectSizes.pagePadding),
          if (showAction)
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: ProjectColors.neutralBlackColor,
                ),
                child: Text(
                  actionText ?? 'Tamam',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: ProjectColors.whiteColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
