import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/product_title_text.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/cart_item_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final bool isDark = HelperFuctions.isDarkMode(context);
    return Row(
      children: [
        RoundedImage(
          isNetworkImage: true,
          imageUrl: cartItem.image,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(ProjectSizes.small),
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
                  child: ProductTitleText(title: cartItem.title, maxLines: 1)),
              Text.rich(TextSpan(
                children: (cartItem.selectedVariation ?? {})
                    .entries
                    .map((e) => TextSpan(children: [
                          TextSpan(
                              text: '${e.key}',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: '${e.value}',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ]))
                    .toList(),
              ))
            ],
          ),
        )
      ],
    );
  }
}
