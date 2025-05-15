import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/icons/circular_icon.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';

import 'package:tarhanaciyasarmobil/features/shop/screens/product_detail/widgets/rate_and_share.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/image_paths.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFuctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: BottomAddToCart(
        product: product,
      ),
      appBar: MyAppbar(
        showBackArrow: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Resim
            Stack(
              children: [
                Container(
                  color: isDark
                      ? ProjectColors.grayColor
                      : ProjectColors.whiteColor,
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      ImagePaths.tereyag,
                      width: DeviceUtility.getScreenWidth(context),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: ProjectSizes.pagePadding,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '350 TL',
                      style: Theme.of(context).textTheme.headlineLarge!.apply(
                            color: ProjectColors.whiteColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),

            Padding(
              padding: const EdgeInsets.all(ProjectSizes.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: ProjectSizes.spaceBtwItems),
                  Text(
                    'Tuzlu Tereyağ',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(fontWeightDelta: 2),
                  ),
                  const RateAndShare(),
                  const SizedBox(height: ProjectSizes.spaceBtwItems),
                  Text('Gramaj',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: ProjectColors.gray2Color)),
                  const SizedBox(height: ProjectSizes.spaceBtwItems),
                  Row(
                    children: [
                      Wrap(
                        spacing: ProjectSizes.spaceBtwItems / 2,
                        children: [
                          ChoiceChip(
                            label: const Text('1kg'),
                            selected: false,
                            onSelected: (value) {},
                          ),
                          ChoiceChip(
                            label: const Text('5kg'),
                            selected: true,
                            onSelected: (value) {},
                            labelStyle: const TextStyle(
                                color: ProjectColors.whiteColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: ProjectSizes.spaceBtwItems),
                  Text(
                    'Ürün Özellikleri',
                    style: Theme.of(context).textTheme.headlineSmall!,
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwItems),
                  ReadMoreText(
                    "Tereyağımız Malatya yöresine ait olup büyükbaş hayvanın tereyağıdır. Tereyağı pilavdan tatlıya, keteden böreğe, tatlıdan kahvaltıya kadar çok geniş bir kullanım alanına sahiptir.Tereyağlarımız 1 er kiloluk vakumlu hava geçirmez poşetlerde sizlere gönderilmektedir.",
                    style: isDark
                        ? Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: ProjectColors.gray4Color)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: ProjectColors.gray3Color),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ProjectTexts.dahaFazlaGoster,
                    trimExpandedText: ProjectTexts.dahaAzGoster,
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFuctions.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    return Container(
      decoration: BoxDecoration(
        color:
            isDark ? ProjectColors.neutralBlackColor : ProjectColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: DeviceUtility.getScreenWidth(context) * 0.4,
                child: Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularIcon(
                          icon: Iconsax.minus,
                          onPressed: () =>
                              controller.productQuantityInCart.value < 1
                                  ? null
                                  : controller.productQuantityInCart.value -=
                                      1),
                      Text(
                        controller.productQuantityInCart.value.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      CircularIcon(
                          icon: Iconsax.add,
                          onPressed: () =>
                              controller.productQuantityInCart.value += 1)
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: DeviceUtility.getScreenWidth(context) * 0.5,
                child: ElevatedButton(
                  onPressed: controller.productQuantityInCart.value < 1
                      ? null
                      : () => controller.addToCart(product),
                  child: Text('Sepete Ekle',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: ProjectColors.whiteColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
