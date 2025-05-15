import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/rounded_container.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/brand_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/widgets/brand_card.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

class BrandShowcase extends StatelessWidget {
  final List<String> images;
  final BrandModel brand;

  const BrandShowcase({super.key, required this.images, required this.brand});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: RoundedContainer(
        borderColor: ProjectColors.grayColor,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ProjectSizes.md),
        margin: const EdgeInsets.only(bottom: ProjectSizes.spaceBtwItems),
        showBorder: true, // Resim yüksekliği
        child: Column(
          children: [
            BrandCard(showBorder: false, brand: brand),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
    child: RoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(ProjectSizes.md),
      margin: const EdgeInsets.only(right: ProjectSizes.small),
      backgroundColor: HelperFuctions.isDarkMode(context)
          ? ProjectColors.grayColor
          : ProjectColors.gray4Color,
      child: Image(
        fit: BoxFit.contain,
        image: AssetImage(image),
      ),
    ),
  );
}
