import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth =
            (constraints.maxWidth - ProjectSizes.spaceBtwItems) / 2;
        double mainAxisExtent = itemWidth * 1.4;

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mainAxisExtent,
            crossAxisCount: 2,
            mainAxisSpacing: ProjectSizes.spaceBtwItems,
            crossAxisSpacing: ProjectSizes.spaceBtwItems,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
