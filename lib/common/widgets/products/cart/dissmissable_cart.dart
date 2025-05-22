import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

import '../../../../features/shop/controllers/cart_controller.dart';
import '../../../../features/shop/models/cart_item_model.dart';
import 'cart_item.dart';

class DismissibleCartItem extends StatelessWidget {
  final CartItemModel item;
  final CartController controller;
  final bool showAddRemoveButtons;
  const DismissibleCartItem({
    super.key,
    required this.item,
    required this.controller,
    this.showAddRemoveButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('${item.productId}-${item.variationId}'), // daha güvenli
      direction: DismissDirection.endToStart,
      background: Container(
        color: ProjectColors.redColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Iconsax.trash, color: Colors.white),
      ),
      onDismissed: (_) {
        controller.removeItemCompletely(item);
      },
      child: CartItem(
        cartItem: item,
        showAddRemoveButtons: showAddRemoveButtons,
      ),
    );
  }
}
