import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/sortable_product.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/brand_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: MyAppbar(
          title: Text(brand.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(fontFamily: 'Poppins'))),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              SizedBox(height: ProjectSizes.spaceBtwItems * 2),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    const loader = VerticalProductShimmer();
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;
                    final brandProducts = snapshot.data!;
                    return SortableProducts(products: brandProducts);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
