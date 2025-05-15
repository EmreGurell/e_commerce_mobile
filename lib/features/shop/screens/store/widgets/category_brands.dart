import 'package:tarhanaciyasarmobil/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/category_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/widgets/brand_show_case.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            ListTileShimmer(),
            SizedBox(height: ProjectSizes.spaceBtwItems),
            BoxesShimmer(),
            SizedBox(height: ProjectSizes.spaceBtwItems),
          ],
        );

        final widget = CloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        final brands = snapshot.data!;
        return ListView.builder(
          // Eksik return eklendi
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                final widget = CloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) return widget;

                final products = snapshot.data!;
                return BrandShowcase(
                  images: products.map((e) => e.thumbnail).toList(),
                  brand: brand,
                );
              },
            );
          },
        );
      },
    );
  }
}
