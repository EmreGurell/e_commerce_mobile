// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tarhanaciyasarmobil/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/widget/add_to_cart_button.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/product_brand_text.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/product_price_text.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final isDark = HelperFuctions.isDarkMode(context);

    // Varyasyonlu ürünlerde lowestPriceWithOriginal extension'ını kullanıyoruz
    final priceInfo = product.lowestPriceWithOriginal;

    // Eğer extension null dönerse fallback için direkt product.price ve salePrice kullanalım
    final double displayPrice = priceInfo != null && priceInfo['salePrice']! > 0
        ? priceInfo['salePrice']!
        : (priceInfo != null ? priceInfo['price']! : product.price);

    final double originalPrice =
        priceInfo != null ? priceInfo['price']! : product.price;

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
            // Görsel ve favori ikonu
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(ProjectSizes.imageAndCardRadius),
                    topRight: Radius.circular(ProjectSizes.imageAndCardRadius),
                  ),
                  child: RoundedImage(
                    applyImageRadius: false,
                    borderRadius: ProjectSizes.imageAndCardRadius,
                    isNetworkImage: true,
                    imageUrl: product.thumbnail,
                    width: double.infinity,
                    height: 175,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: FavouriteIcon(productId: product.id),
                ),
              ],
            ),
            const SizedBox(height: ProjectSizes.small),

            // Ürün başlığı
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ProjectSizes.small),
              child: ProductTitleText(
                smallSize: true,
                title: product.title.toUpperCase(),
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: ProjectSizes.small / 2),

            // Marka
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ProjectSizes.small),
              child: ProductBrandText(
                title: product.brand?.name ?? '',
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems * 0.8),

            // Fiyat ve sepete ekle
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ProjectSizes.small),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProductPriceText(
                    price: originalPrice,
                    salePrice: displayPrice,
                    maxLines: 1,
                    isLarge: true,
                  ),
                  // Sadece single ürünlerde sepete ekle butonu göster
                  if (product.productType == ProductType.single.toString())
                    AddToCartButton(product: product)
                  else
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 18),
                      onPressed: () =>
                          Get.to(ProductDetailScreen(product: product)),
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
