import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/brand_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/category_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/search_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/all_categories/category_products.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/brands/widgets/brand_card.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/store/widgets/store_appbar.dart';

import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    final searchController = Get.put(MySearchController());

    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: StoreScreenAppBar(controller: searchController),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ProjectSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🏷️ Kategoriler
            Text('Kategoriler', style: Theme.of(context).textTheme.titleLarge),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 4,
                runSpacing: 8,
                children: categories.map((category) {
                  return ActionChip(
                    side: BorderSide.none,
                    label: Text(category.name),
                    onPressed: () =>
                        Get.to(() => CategoryProducts(category: category)),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ProjectSizes.spaceBtwItems),

            /// 🏭 Markalar
            Text('Markalar', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: ProjectSizes.spaceBtwItems / 2),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: ProjectSizes.small,
                runSpacing: ProjectSizes.small,
                children: brandController.featuredBrands.map((brand) {
                  return SizedBox(
                    height: 75,
                    width: 150,
                    child: BrandCard(brand: brand, showBorder: false),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ProjectSizes.spaceBtwItems),
            Text('Ürünler', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: ProjectSizes.spaceBtwItems),

            Obx(() {
              return Column(children: [
                if (searchController.isLoading.value)
                  const Center(child: CircularProgressIndicator())
                else if (searchController.products.isEmpty)
                  const Center(child: Text('Aramanıza uygun ürün bulunamadı'))
                else
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                      crossAxisSpacing: ProjectSizes.spaceBtwItems,
                      mainAxisSpacing: ProjectSizes.spaceBtwItems,
                    ),
                    itemCount: searchController.products.length,
                    itemBuilder: (context, index) {
                      final product = searchController.products[index];
                      return ProductCardVertical(product: product);
                    },
                  )
              ]);
            }),
          ],
        ),
      ),
    );
  }
}
