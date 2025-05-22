import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/sortable_product.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/category_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: MyAppbar(
          title: Text(category.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(fontFamily: 'Poppins'))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    const loader = VerticalProductShimmer();
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    final categoryProducts = snapshot.data!;
                    return SortableProducts(products: categoryProducts);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
