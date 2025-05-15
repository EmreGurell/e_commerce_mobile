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
  });
  final Color? textColor;
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
            TextButton(
                onPressed: onPressed,
                child: Text(
                  showActionButton ? buttonTitle! : '',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: textColor),
                ))
          ]),
        ],
      ),
    );
  }
}
