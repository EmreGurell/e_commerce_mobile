import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../models/brand_model.dart';

class BrandCard extends StatelessWidget {
  final BrandModel brand;
  final bool showBorder;
  final VoidCallback? onTap;

  const BrandCard({
    super.key,
    required this.brand,
    this.showBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: showBorder ? Border.all(color: Colors.grey.shade300) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: RoundedImage(imageUrl: brand.image,isNetworkImage: true,width: 60,height: 60)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${brand.productsCount} ürün',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class BrandCard2 extends StatelessWidget {
  final BrandModel brand;
  final bool showBorder;
  final VoidCallback? onTap;

  const BrandCard2({
    super.key,
    required this.brand,
    this.showBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(height: 150,padding: EdgeInsets.all(ProjectSizes.pagePadding/3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ProjectSizes.imageAndCardRadius),
          border: showBorder ? Border.all(color: Colors.grey.shade300) : null,

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: RoundedImage(imageUrl: brand.image,isNetworkImage: true,width: 60,height: 60)),SizedBox(height: ProjectSizes.spaceBtwItems/2),
            Text(textAlign: TextAlign.center,
              brand.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${brand.productsCount} ürün',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}