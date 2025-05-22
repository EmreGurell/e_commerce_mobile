import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 300,
    this.crossAxisCount = 2,
  });

  final int itemCount, crossAxisCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final double mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = (constraints.maxWidth - ProjectSizes.spaceBtwItems) /
            crossAxisCount;

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: mainAxisExtent,
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: ProjectSizes.spaceBtwItems,
            crossAxisSpacing: ProjectSizes.small,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
