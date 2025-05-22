import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/product_brand_text.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/product_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/variation_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/product_detail/widgets/product_attributes.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/product_detail/widgets/product_detail_price_text.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/product_detail/widgets/product_image_slider.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final selectedVariation = productController.selectedVariation;

    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty &&
        selectedVariation.value.id.isEmpty) {
      selectedVariation.value = product.productVariations!.first;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAddToCart(product: product),
      appBar: MyAppbar(
        backIconColor: Colors.white,
        backgroundColor: Colors.transparent,
        showBackArrow: true,
        actions: [
          FavouriteIcon(
            productId: product.id,
            backgroundColor: Colors.white,
          ),
          const ShoppingCartCounter(
            backgroundColor: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageSlider(
              product: product,
            ),
            const SizedBox(height: ProjectSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ProjectSizes.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title.toUpperCase(),
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(fontFamily: 'Poppins'),
                  ),
                  ProductBrandText(title: product.brand!.name, maxLines: 1),
                  const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
                  const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
                  ProductAttributes(product: product),
                  const SizedBox(height: ProjectSizes.spaceBtwItems),
                  Text(
                    'Ürün Açıklaması',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: ProjectColors.neutralBlackColor),
                  ),
                  const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
                  product.productType == ProductType.single.toString()
                      ? ReadMoreText(
                          product.description ?? '',
                          trimLines: 5, // kaç satırdan sonra kısaltsın
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Devamını Oku',
                          trimExpandedText: 'Daha Az Göster',
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: ProjectColors.gray2Color,
                              fontFamily: 'Poppins'),
                        )
                      : Obx(() => ReadMoreText(
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontFamily: 'Poppins',
                                    ),
                            lessStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                                    fontWeightDelta: 2,
                                    color: Theme.of(context).primaryColor),
                            moreStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(
                                    fontWeightDelta: 2,
                                    color: Theme.of(context).primaryColor),
                            VariationController.instance.selectedVariation.value
                                    .description ??
                                '',
                            trimLines: 5, // kaç satırdan sonra kısaltsın
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Devamını Oku',
                            trimExpandedText: 'Daha Az Göster',
                          )),
                  // Text(
                  //   textAlign: TextAlign.end,
                  //   'Stok: ${product.stock}',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodySmall!
                  //       .apply(color: ProjectColors.gray3Color),
                  // ),
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
  const BottomAddToCart({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    Get.find<ProductController>();

    return Container(
      decoration: const BoxDecoration(
        color: ProjectColors.whiteColor,
      ),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Row(
          children: [
            /// FİYAT KISMI
            Expanded(
              flex: 1,
              child: Obx(() {
                final variation =
                    VariationController.instance.selectedVariation.value;

                if (product.productType == ProductType.single.toString()) {
                  return ProductDetailPriceText(
                    price: product.price,
                    salePrice: product.salePrice,
                    maxLines: 1,
                  );
                } else {
                  return ProductDetailPriceText(
                    price: variation.price,
                    salePrice: variation.salePrice,
                    maxLines: 1,
                  );
                }
              }),
            ),
            const SizedBox(width: 8),

            /// SEPET KONTROLLERİ
            Expanded(
              flex: 3,
              child: Obx(() {
                final isVariable =
                    product.productType == ProductType.variable.toString();
                final variation =
                    controller.variationController.selectedVariation.value;

                final availableStock = isVariable
                    ? (variation.id.isNotEmpty ? variation.stock : 0)
                    : product.stock;

                final isInStock = availableStock > 0;

                if (!isInStock) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text(
                        'Stokta Yok',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: ProjectColors.whiteColor),
                      ),
                    ),
                  );
                }

                return Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.productQuantityInCart.value = 1;
                        controller.addToCart(product);
                      },
                      child: Text(
                        'Sepete Ekle',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: ProjectColors.whiteColor),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
