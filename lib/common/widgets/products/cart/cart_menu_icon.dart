import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/variation_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/cart/cart.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ShoppingCartCounter extends StatelessWidget {
  const ShoppingCartCounter(
      {super.key, this.iconColor, this.backgroundColor = Colors.transparent});
  final Color? iconColor, backgroundColor;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    Get.put(VariationController());
    return Stack(children: [
      IconButton(
          style: IconButton.styleFrom(backgroundColor: backgroundColor),
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(
            Iconsax.shopping_cart,
            color: iconColor,
          )),
      Positioned(
        right: 0,
        child: Container(
          width: ProjectSizes.IconS * 1.3,
          height: ProjectSizes.IconS * 1.3,
          decoration: BoxDecoration(
              color: ProjectColors.redColor,
              borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Obx(
              () => Text(
                controller.noOfCartItems.value.toString(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: ProjectColors.whiteColor, fontSizeFactor: .8),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
