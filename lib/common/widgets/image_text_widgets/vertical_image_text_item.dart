import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

class VerticalImageCategoryItem extends StatelessWidget {
  const VerticalImageCategoryItem({
    super.key,
    required this.image,
    required this.title,
    this.textColor = ProjectColors.whiteColor,
    this.backgroundColor = ProjectColors.whiteColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFuctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ProjectSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(ProjectSizes.IconXS / 2),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: backgroundColor ??
                    (isDark
                        ? ProjectColors.neutralBlackColor
                        : ProjectColors.whiteColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: RoundedImage(
                  width: double.infinity,
                  imageUrl: image,
                  isNetworkImage: isNetworkImage,
                  fit: BoxFit.cover,
                  applyImageRadius: true,
                ),
              ),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
            SizedBox(
              width: 56,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
