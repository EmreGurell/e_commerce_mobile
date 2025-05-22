import 'package:tarhanaciyasarmobil/common/widgets/products/cart/cart_item.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/cart_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/dissmissable_cart.dart';

class CartItems extends StatelessWidget {
  const CartItems(
      {super.key, this.showAddRemoveButtons = true, required this.dismissable});
  final bool showAddRemoveButtons, dismissable;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => SizedBox(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: cartController.cartItems.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: ProjectSizes.spaceBtwItems / 2,
          ),
          itemBuilder: (_, index) {
            final item = cartController.cartItems[index];
            if (dismissable) {
              return DismissibleCartItem(
                item: item,
                showAddRemoveButtons: showAddRemoveButtons,
                controller: cartController,
              );
            } else {
              return CartItem(cartItem: item);
            }
          },
        ),
      ),
    );
  }
}
