import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/enums.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(() {
      final productQuantityInCart =
          cartController.getProductQuantityInCart(product.id);

      return Row(
        children: [
          // - Butonu
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.5, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
            child: productQuantityInCart > 0
                ? InkWell(
                    key: const ValueKey("minus"),
                    onTap: () {
                      if (product.productType ==
                          ProductType.single.toString()) {
                        final cartItem =
                            cartController.convertToCartItem(product, 1);
                        cartController.removeOneFromCart(cartItem, context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ProjectColors.whiteColor,
                        borderRadius: BorderRadius.circular(ProjectSizes.small),
                      ),
                      child: const Icon(
                        Iconsax.minus,
                        color: ProjectColors.neutralBlackColor,
                        size: 20,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          const SizedBox(width: ProjectSizes.spaceBtwItems / 2),

          // Adet veya + Butonu
          InkWell(
            onTap: () {
              if (product.productType == ProductType.single.toString()) {
                cartController.addToCart(product);
              }
            },
            child: productQuantityInCart > 0
                ? Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ProjectColors.greenColor,
                      borderRadius: BorderRadius.circular(ProjectSizes.small),
                    ),
                    child: SizedBox(
                      width: 20,
                      child: Text(
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        productQuantityInCart.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: ProjectColors.whiteColor),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ProjectColors.greenColor,
                      borderRadius: BorderRadius.circular(ProjectSizes.small),
                    ),
                    child: const Icon(
                      Iconsax.add,
                      color: ProjectColors.whiteColor,
                      size: 20,
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
