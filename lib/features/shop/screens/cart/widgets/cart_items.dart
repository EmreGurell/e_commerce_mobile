import 'package:tarhanaciyasarmobil/common/widgets/products/cart/add_remove.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/cart/cart_item.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/product_price_text.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    this.showAddRemoveButtons = true,
    super.key,
  });
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: ProjectSizes.spaceBtwItems * 2,
        ),
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              CartItem(cartItem: item),
              if (showAddRemoveButtons)
                const SizedBox(
                  height: ProjectSizes.spaceBtwItems,
                ),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProductQuantity(
                      quantity: item.quantity,
                      add: () => cartController.addOneCart(item),
                      remove: () => cartController.removeOneFromCart(item),
                    ),
                    const SizedBox(width: ProjectSizes.spaceBtwItems),
                    ProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1),
                        maxLines: 1,
                        isLarge: true),
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}
