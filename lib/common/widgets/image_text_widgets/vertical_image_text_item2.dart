import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
// import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';

class VerticalImageCategoryItem2 extends StatelessWidget {
  const VerticalImageCategoryItem2({
    super.key,
    required this.image,
    required this.title,
    this.textColor = ProjectColors.whiteColor,
    this.backgroundColor = ProjectColors.whiteColor,
    this.onTap,
    this.isNetworkImage = true,
    required this.width,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;
  final double width;

  @override
  Widget build(BuildContext context) {
    // final isDark = HelperFuctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ProjectSizes.spaceBtwItems / 2),
        child: Stack(
          children: [
            /// 🖼 Arka Plan Resmi
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: RoundedImage(
                width: width,
                height: 200,
                imageUrl: image,
                isNetworkImage: isNetworkImage,
                fit: BoxFit.cover,
                applyImageRadius: true,
              ),
            ),

            /// 💎 Blur + Yazı katmanı
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    color: Colors.black.withOpacity(0.4),
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
