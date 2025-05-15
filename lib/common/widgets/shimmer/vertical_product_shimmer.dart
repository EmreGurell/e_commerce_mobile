import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/shimmer_effect_loader.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ShimmerEffect(width: 180, height: 180),
            SizedBox(height: ProjectSizes.spaceBtwItems),

            /// Text
            ShimmerEffect(width: 160, height: 15),
            SizedBox(height: ProjectSizes.spaceBtwItems / 2),
            ShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
