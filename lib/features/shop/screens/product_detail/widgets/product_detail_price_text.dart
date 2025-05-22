import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

class ProductDetailPriceText extends StatelessWidget {
  const ProductDetailPriceText({
    super.key,
    required this.price,
    required this.maxLines,
    this.textAlign,
    this.moneyText = 'TL',
    this.salePrice,
  });
  final double price;
  final double? salePrice;
  final int maxLines;
  final TextAlign? textAlign;
  final String moneyText;
  @override
  Widget build(BuildContext context) {
    if (price == salePrice && salePrice! > 0) {
      return Text(
        '$price $moneyText',
        style: Theme.of(context).textTheme.headlineSmall!.apply(
              overflow: TextOverflow.ellipsis,
            ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$price $moneyText',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: ProjectColors.neutralBlackColor,
                  )),
          Text('$salePrice $moneyText',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontFamily: 'Poppins', color: Colors.red))
        ],
      );
    }
  }
}
