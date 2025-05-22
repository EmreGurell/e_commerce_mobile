import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    required this.price,
    this.isLarge = false,
    this.lineThrough = false,
    required this.maxLines,
    this.textAlign,
    this.moneyText = 'TL',
    this.salePrice,
  });
  final double price;
  final double? salePrice;
  final bool isLarge, lineThrough;
  final int maxLines;
  final TextAlign? textAlign;
  final String moneyText;
  @override
  Widget build(BuildContext context) {
    if (price == salePrice && salePrice! > 0) {
      return Text(
        '$price $moneyText',
        style: isLarge
            ? Theme.of(context).textTheme.headlineSmall!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null)
            : Theme.of(context).textTheme.labelLarge!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null),
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Text(
                '$price $moneyText',
                style: isLarge
                    ? Theme.of(context).textTheme.titleSmall!.apply(
                        decoration: TextDecoration.lineThrough,
                        color: ProjectColors.neutralBlackColor)
                    : Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(decoration: TextDecoration.lineThrough),
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
                textAlign: textAlign,
              ),
            ],
          ),
          Text(
            '$salePrice $moneyText',
            style: isLarge
                ? Theme.of(context).textTheme.headlineSmall!.apply(
                    decoration: lineThrough ? TextDecoration.lineThrough : null)
                : Theme.of(context).textTheme.labelLarge!.apply(
                    decoration:
                        lineThrough ? TextDecoration.lineThrough : null),
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            textAlign: textAlign,
          )
        ],
      );
    }
  }
}
