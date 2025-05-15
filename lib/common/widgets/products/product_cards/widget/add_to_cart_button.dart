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
    return InkWell(
      onTap: () {
        // Sepete ekleme işlemi
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneCart(cartItem);
        } else {}
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: productQuantityInCart > 0
                ? ProjectColors.blueColor
                : ProjectColors.neutralBlackColor,
            borderRadius: BorderRadius.circular(ProjectSizes.small),
          ),
          child: productQuantityInCart > 0
              ? Text(
                  productQuantityInCart.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: ProjectColors.whiteColor),
                )
              : const Icon(
                  Iconsax.add,
                  color: ProjectColors.whiteColor,
                  size: 20,
                ),
        );
      }),
    );
  }
}
