import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RateAndShare extends StatelessWidget {
  const RateAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Star Icon
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: ProjectColors.orange2Color,
              size: 24,
            ),
            // Spacer
            const SizedBox(
              width: 8, // TSize.spaceBtwItems / 2'ye denk gelir.
            ),
            // Rich Text
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '5.0 ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const TextSpan(
                    text: '| 199 vote',
                  ),
                ],
              ),
            ),
          ],
        ),
        // Share Button
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
            size: ProjectSizes.IconM,
          ),
        ),
      ],
    );
  }
}
