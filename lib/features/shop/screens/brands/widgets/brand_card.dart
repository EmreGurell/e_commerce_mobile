import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/common/widgets/images/rounded_image.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(ProjectSizes.small),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ProjectSizes.imageAndCardRadius),
          border:
              showBorder ? Border.all(color: ProjectColors.greenColor) : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundedImage(
              applyImageRadius: true,
              padding: const EdgeInsets.all(0),
              imageUrl: brand.image,
              isNetworkImage: true,
              width: 45,
              height: 45,
            ),
            const SizedBox(width: ProjectSizes.small),
            // Yazı alanı sığmazsa sarıp küçülsün diye Flexible ekleniyor
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand.name.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FutureBuilder<int>(
                    future: BrandController.instance
                        .calculateProductCount(brand.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Yükleniyor...');
                      } else if (snapshot.hasError) {
                        return const Text('Hata oluştu');
                      } else {
                        return Text('${snapshot.data ?? 0} ürün');
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
