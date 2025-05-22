import 'package:tarhanaciyasarmobil/common/widgets/icons/circular_icon.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
    this.column = true,
    this.width = 32,
    this.height = 32,
  });
  final int quantity;
  final VoidCallback? add, remove;
  final bool column;
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return column
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 100),
              // Add Remove Buttons
              Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ProjectSizes.imageAndCardRadius),
                  color: ProjectColors.gray4Color.withOpacity(.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularIcon(
                      circular: false,
                      radius: ProjectSizes.imageAndCardRadius,
                      onPressed: add,
                      icon: Iconsax.add,
                      width: width,
                      height: height,
                      size: ProjectSizes.IconS,
                      color: ProjectColors.neutralBlackColor,
                      backgroundColor: ProjectColors.gray4Color.withOpacity(.5),
                    ),
                    const SizedBox(width: ProjectSizes.spaceBtwItems),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(quantity.toString(),
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    const SizedBox(width: ProjectSizes.spaceBtwItems),
                    CircularIcon(
                        circular: false,
                        radius: ProjectSizes.imageAndCardRadius,
                        onPressed: remove,
                        icon: Iconsax.minus,
                        width: width,
                        height: height,
                        size: ProjectSizes.IconS,
                        color: HelperFuctions.isDarkMode(context)
                            ? ProjectColors.neutralBlackColor
                            : ProjectColors.neutralBlackColor,
                        backgroundColor: Colors.white.withOpacity(.5)),
                  ],
                ),
              ),
            ],
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(ProjectSizes.imageAndCardRadius),
              color: ProjectColors.gray4Color.withOpacity(.5),
            ),
            child: Row(
              children: [
                CircularIcon(
                    circular: false,
                    radius: ProjectSizes.imageAndCardRadius,
                    onPressed: remove,
                    icon: Iconsax.minus,
                    width: width,
                    height: height,
                    size: ProjectSizes.IconS,
                    color: HelperFuctions.isDarkMode(context)
                        ? ProjectColors.neutralBlackColor
                        : ProjectColors.neutralBlackColor,
                    backgroundColor: Colors.white.withOpacity(.5)),
                const SizedBox(width: ProjectSizes.spaceBtwItems),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(quantity.toString(),
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
                const SizedBox(width: ProjectSizes.spaceBtwItems),
                CircularIcon(
                  circular: false,
                  radius: ProjectSizes.imageAndCardRadius,
                  onPressed: add,
                  icon: Iconsax.add,
                  width: width,
                  height: height,
                  size: ProjectSizes.IconS,
                  color: ProjectColors.neutralBlackColor,
                  backgroundColor: ProjectColors.gray4Color.withOpacity(.5),
                ),
              ],
            ),
          );
  }
}
