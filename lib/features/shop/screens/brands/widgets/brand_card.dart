import 'package:tarhanaciyasarmobil/features/shop/models/brand_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final bool showBorder;
  final BrandModel brand;

  const BrandCard({Key? key, required this.showBorder, required this.brand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: showBorder
          ? RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            if (brand.image.isNotEmpty)
              Image.network(
                brand.image,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported),
              )
            else
              const Icon(Icons.image, size: 50, color: Colors.grey),
            const SizedBox(width: ProjectSizes.small),
            Text(
              brand.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
