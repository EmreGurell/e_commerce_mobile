import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/primary_header_container.dart';
import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/search_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/layouts/grid_layout.dart';
import 'package:tarhanaciyasarmobil/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:tarhanaciyasarmobil/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/product/product_controller.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/all_products/all_products.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/widgets/home_categories.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/widgets/slider_with_dots.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  const HomeScreenAppBar(),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
                  const SearchBarContainer(
                    showBackground: true,
                    showBorder: true,
                    text: ProjectTexts.search,
                    icon: Iconsax.search_normal,
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
                  SectionHeading(
                    title: ProjectTexts.popularCategories,
                    buttonTitle: ProjectTexts.viewAllProducts,
                    onPressed: () => Get.to(() => AllProducts(
                          futureMethod: controller.fetchAllFeaturedProducts(),
                          title: 'Popüler Ürünler',
                        )),
                    showActionButton: true,
                    textColor: ProjectColors.whiteColor,
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
                  const HomeCategories(),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems * 2,
                  ),
                ],
              ),
            ),
            const SliderWithDots(),
            Padding(
              padding: const EdgeInsets.all(ProjectSizes.pagePadding),
              child: Column(
                children: [
                  const SizedBox(height: ProjectSizes.spaceBtwItems * 2),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const VerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return const Center(
                        child: Text('Veri Bulunamadı'),
                      );
                    }
                    return GridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => ProductCardVertical(
                          product: controller.featuredProducts[index]),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
