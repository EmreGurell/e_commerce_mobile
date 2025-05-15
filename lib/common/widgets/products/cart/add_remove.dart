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
  });
  final int quantity;
  final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 70),
        // Add Remove Buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularIcon(
              onPressed: remove,
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: ProjectSizes.IconS,
              color: HelperFuctions.isDarkMode(context)
                  ? ProjectColors.whiteColor
                  : ProjectColors.neutralBlackColor,
              backgroundColor: HelperFuctions.isDarkMode(context)
                  ? ProjectColors.grayColor
                  : ProjectColors.gray4Color,
            ),
            const SizedBox(width: ProjectSizes.spaceBtwItems),
            Text(quantity.toString(),
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: ProjectSizes.spaceBtwItems),
            CircularIcon(
              onPressed: add,
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: ProjectSizes.IconS,
              color: ProjectColors.whiteColor,
              backgroundColor: ProjectColors.blueColor,
            ),
          ],
        ),
      ],
    );
  }
}
