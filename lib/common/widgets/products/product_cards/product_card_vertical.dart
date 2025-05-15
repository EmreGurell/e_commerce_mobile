// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tarhanaciyasarmobil/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/widget/add_to_cart_button.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/product_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/product_title_text.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/product_detail/product_detail.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    final isDark = HelperFuctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(ProductDetailScreen(product: product)),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ProjectSizes.imageAndCardRadius),
          color: isDark ? ProjectColors.gray2Color : ProjectColors.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ürün görseli
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(ProjectSizes.imageAndCardRadius),
                  child: RoundedImage(
                    isNetworkImage: true,
                    imageUrl: product.thumbnail,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                // İstek listesine ekleme butonu (Kalp ikonu)
                Positioned(
                  top: 8,
                  right: 8,
                  child: FavouriteIcon(
                    productId: product.id,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ProjectSizes.small),
            // Ürün başlığı
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ProjectSizes.small),
              child: ProductTitleText(
                title: product.title,
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: ProjectSizes.small / 2),
            // Fiyat ve Sepete Ekle Butonu
            Flexible(
              child: Column(
                children: [
                  if (product.productType == ProductType.single.toString() &&
                      product.salePrice > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ProjectSizes.small),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .apply(
                                      decoration: TextDecoration.lineThrough)),
                          AddToCartButton(
                            product: product,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: ProjectSizes.small),
          ],
        ),
      ),
    );
  }
}
