import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    required this.price,
    this.isLarge = false,
    this.lineThrough = false,
    required this.maxLines,
    this.textAlign,
    this.moneyText = '₺',
  });
  final String price;
  final bool isLarge, lineThrough;
  final int maxLines;
  final TextAlign? textAlign;
  final String moneyText;
  @override
  Widget build(BuildContext context) {
    return Text(
      price + moneyText,
      style: isLarge
          ? Theme.of(context).textTheme.headlineSmall!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.labelLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
