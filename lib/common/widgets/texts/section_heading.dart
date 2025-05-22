import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    required this.showActionButton,
    required this.title,
    this.buttonTitle,
    this.onPressed,
    this.buttonColor,
  });
  final Color? textColor, buttonColor;
  final bool showActionButton;
  final String title;
  final String? buttonTitle;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: ProjectSizes.pagePadding),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (showActionButton)
              TextButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: onPressed,
                label: Text(
                  buttonTitle!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: buttonColor),
                ),
                icon: Icon(
                  Iconsax.arrow_right_3,
                  color: buttonColor,
                  size: ProjectSizes.IconM * .8,
                ),
              ),
          ]),
        ],
      ),
    );
  }
}
