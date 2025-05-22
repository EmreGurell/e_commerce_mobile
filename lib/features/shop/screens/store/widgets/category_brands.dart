import 'package:tarhanaciyasarmobil/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/category_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/widgets/brand_show_case.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:flutter/material.dart';

import '../../../models/brand_model.dart';
import '../../../models/product_model.dart';
class CategoryBrands extends StatelessWidget {
  const CategoryBrands({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    final List<Color> usedColors = []; // renkleri burada topla

    return FutureBuilder<List<BrandModel>>(
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

        final brands = snapshot.data ?? [];
        if (brands.isEmpty) {
          return const Center(child: Text('Marka bulunamadı'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];

            return FutureBuilder<List<ProductModel>>(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                final widget = CloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) return widget;

                final products = snapshot.data ?? [];

                return BrandShowcase(
                  images: products.map((e) => e.thumbnail).toList(),
                  brand: brand,
                  usedColors: usedColors, // aynı listeyi geçir
                  index: index, // index'i geçir
                );
              },
            );
          },
        );
      },
    );
  }
}


