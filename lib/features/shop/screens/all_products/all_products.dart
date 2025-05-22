import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/sortable_product.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/all_products_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/product_model.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    // Controller'ı yalnızca bir kez oluştur
    final controller = Get.put(AllProductsController(), permanent: true);

    return Scaffold(
      appBar: MyAppbar(showBackArrow: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ProjectSizes.pagePadding),
          child: FutureBuilder<List<ProductModel>>(
            future: futureMethod ?? controller.fetchProductByQuery(query),
            builder: (context, snapshot) {
              const loader = VerticalProductShimmer();
              final widget = CloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
                loader: loader,
              );

              if (widget != null) return widget;

              final products = snapshot.data ?? [];

              // Ürünler geldikten sonra controller'a atanıyor
              controller.assignProducts(products);

              return SortableProducts(
                products: products,
              );
            },
          ),
        ),
      ),
    );
  }
}
