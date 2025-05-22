import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

class ProductBrandText extends StatelessWidget {
  const ProductBrandText({
    super.key,
    required this.title,
    required this.maxLines,
    this.textAlign,
  });
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontFamily: 'Poppins',
              color: ProjectColors.greenColor),
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          textAlign: textAlign,
        ),
        const SizedBox(width: 2),
         Icon(
          Iconsax.verify5,
          color: ProjectColors.green2Color.withOpacity(.9),
          size: 18,
        )
      ],
    );
  }
}
