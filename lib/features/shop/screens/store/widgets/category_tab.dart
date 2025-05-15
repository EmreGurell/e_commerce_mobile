import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/category_model.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/all_products/all_products.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/store/widgets/category_brands.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.category,
  });

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(ProjectSizes.pagePadding),
            child: Column(
              children: [
                CategoryBrands(category: category),
                SizedBox(
                  height: ProjectSizes.spaceBtwItems,
                ),
                FutureBuilder(
                    future:
                        controller.getCategoryProducts(categoryId: category.id),
                    builder: (context, snapshot) {
                      final response =
                          CloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: const VerticalProductShimmer());
                      if (response != null) return response;

                      final products = snapshot.data!;
                      return Column(
                        children: [
                          SectionHeading(
                            title: 'En Çok Satan Ürünler',
                            buttonTitle: ProjectTexts.viewAllProducts,
                            onPressed: () => Get.to(AllProducts(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            )),
                            showActionButton: true,
                          ),
                          const SizedBox(height: ProjectSizes.spaceBtwItems),
                          GridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) =>
                                  ProductCardVertical(product: products[index]))
                        ],
                      );
                    }),
              ],
            ),
          ),
        ]);
  }
}
