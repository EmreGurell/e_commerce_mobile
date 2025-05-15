import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding =
        const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFuctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: DeviceUtility.getScreenWidth(context),
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          decoration: BoxDecoration(
              color: showBackground
                  ? isDark
                      ? ProjectColors.whiteColor
                      : ProjectColors.whiteColor
                  : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(ProjectSizes.imageAndCardRadius),
              border: Border.all(
                color: showBorder
                    ? isDark
                        ? ProjectColors.whiteColor
                        : ProjectColors.gray4Color
                    : Colors.transparent,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: ProjectColors.gray3Color,
              ),
              const SizedBox(
                width: ProjectSizes.spaceBtwItems,
              ),
              Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: ProjectColors.gray3Color))
            ],
          ),
        ),
      ),
    );
  }
}
