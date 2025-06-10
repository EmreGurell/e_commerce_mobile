import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/product_title_text.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/cart_item_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/box_shadow.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

import '../../../../features/shop/controllers/cart_controller.dart';
import '../../texts/product_price_text.dart';
import 'add_remove.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItem,
    this.showAddRemoveButtons = false,
  });

  final CartItemModel cartItem;
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final bool isDark = HelperFuctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(ProjectSizes.small / 2),
      decoration: BoxDecoration(
          boxShadow: [ProjectBoxShadow.lowCardShadow],
          color: ProjectColors.whiteColor,
          borderRadius: BorderRadius.circular(ProjectSizes.imageAndCardRadius)),
      child: Row(children: [
        RoundedImage(
          applyImageRadius: true,
          borderRadius: ProjectSizes.imageAndCardRadius,
          isNetworkImage: true,
          imageUrl: cartItem.image,
          width: 80,
          height: 80,
          backgroundColor:
              isDark ? ProjectColors.grayColor : ProjectColors.gray4Color,
        ),
        const SizedBox(width: ProjectSizes.spaceBtwItems),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Marka eklenebilir.
              Flexible(
                  child: Text(
                cartItem.title.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontFamily: 'Poppins'),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
              Text.rich(TextSpan(
                children: (cartItem.selectedVariation ?? {})
                    .entries
                    .map((e) => TextSpan(children: [
                          TextSpan(
                              text: '${e.key}: ',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: '${e.value}',
                              style: Theme.of(context).textTheme.bodySmall),
                        ]))
                    .toList(),
              )),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems,
              ),
              ProductPriceText(
                  salePrice: cartItem.price * cartItem.quantity,
                  price: cartItem.price * cartItem.quantity,
                  maxLines: 1,
                  isLarge: true),
            ],
          ),
        ),
        if (showAddRemoveButtons)
          const SizedBox(
            height: ProjectSizes.spaceBtwItems,
          ),
        if (showAddRemoveButtons)
          ProductQuantity(
            quantity: cartItem.quantity,
            add: () => CartController.instance.addOneCart(
              cartItem,
            ),
            remove: () =>
                CartController.instance.removeOneFromCart(cartItem, context),
          )
      ]),
    );
  }
}
